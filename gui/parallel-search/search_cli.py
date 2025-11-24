#!/usr/bin/env python3
"""
Parallel Search CLI Tool
Displays normal search results and AI search results side by side in the terminal.
"""

import asyncio
import os
import sys
from typing import List, Dict, Optional
import argparse
from dataclasses import dataclass

import anthropic
from duckduckgo_search import DDGS
from rich.console import Console
from rich.columns import Columns
from rich.panel import Panel
from rich.markdown import Markdown
from rich.live import Live
from rich.layout import Layout
from rich.text import Text


@dataclass
class SearchResult:
    """Represents a single search result."""
    title: str
    url: str
    snippet: str


class DuckDuckGoSearcher:
    """Handles DuckDuckGo search operations."""

    def __init__(self, max_results: int = 5):
        self.max_results = max_results

    def search(self, query: str) -> List[SearchResult]:
        """Perform a DuckDuckGo search."""
        try:
            results = []
            with DDGS() as ddgs:
                for result in ddgs.text(query, max_results=self.max_results):
                    results.append(SearchResult(
                        title=result.get('title', 'No title'),
                        url=result.get('href', ''),
                        snippet=result.get('body', '')
                    ))
            return results
        except Exception as e:
            return [SearchResult(
                title="Error",
                url="",
                snippet=f"DuckDuckGo search failed: {str(e)}"
            )]


class ClaudeSearcher:
    """Handles Claude AI search operations."""

    def __init__(self, api_key: Optional[str] = None):
        self.api_key = api_key or os.getenv('ANTHROPIC_API_KEY')
        if not self.api_key:
            raise ValueError("ANTHROPIC_API_KEY environment variable not set")
        self.client = anthropic.Anthropic(api_key=self.api_key)

    async def search(self, query: str) -> str:
        """Perform an AI search using Claude."""
        try:
            prompt = f"""あなたは検索アシスタントです。以下の検索クエリに対して、簡潔で分かりやすい回答を提供してください。

検索クエリ: {query}

以下の形式で回答してください：
1. 概要（2-3文で）
2. 主なポイント（箇条書き）
3. 補足情報（必要に応じて）

回答はMarkdown形式で記述してください。"""

            message = self.client.messages.create(
                model="claude-3-5-sonnet-20241022",
                max_tokens=1024,
                messages=[
                    {"role": "user", "content": prompt}
                ]
            )

            return message.content[0].text
        except Exception as e:
            return f"**Error**: Claude AI search failed: {str(e)}"


class ParallelSearchCLI:
    """Main CLI application for parallel search."""

    def __init__(self, max_results: int = 5):
        self.console = Console()
        self.ddg_searcher = DuckDuckGoSearcher(max_results=max_results)
        self.claude_searcher = ClaudeSearcher()

    def format_ddg_results(self, results: List[SearchResult]) -> Panel:
        """Format DuckDuckGo search results as a Rich panel."""
        if not results:
            content = Text("No results found", style="dim")
        else:
            lines = []
            for i, result in enumerate(results, 1):
                lines.append(f"[bold cyan]{i}. {result.title}[/bold cyan]")
                lines.append(f"[dim]{result.url}[/dim]")
                lines.append(f"{result.snippet}\n")
            content = "\n".join(lines)

        return Panel(
            content,
            title="🔍 DuckDuckGo Search",
            border_style="blue",
            padding=(1, 2)
        )

    def format_claude_results(self, response: str) -> Panel:
        """Format Claude AI response as a Rich panel."""
        md = Markdown(response)
        return Panel(
            md,
            title="🤖 Claude AI Search",
            border_style="green",
            padding=(1, 2)
        )

    async def perform_searches(self, query: str) -> tuple[List[SearchResult], str]:
        """Perform both searches in parallel."""
        # Run DuckDuckGo search in executor (it's synchronous)
        loop = asyncio.get_event_loop()
        ddg_task = loop.run_in_executor(None, self.ddg_searcher.search, query)

        # Run Claude search (it's async)
        claude_task = self.claude_searcher.search(query)

        # Wait for both to complete
        ddg_results, claude_response = await asyncio.gather(ddg_task, claude_task)

        return ddg_results, claude_response

    async def run(self, query: str):
        """Run the parallel search CLI."""
        self.console.print(f"\n[bold yellow]Searching for:[/bold yellow] {query}\n")

        with self.console.status("[bold green]Searching...", spinner="dots"):
            ddg_results, claude_response = await self.perform_searches(query)

        # Create layout with two columns
        layout = Layout()
        layout.split_row(
            Layout(self.format_ddg_results(ddg_results), name="left"),
            Layout(self.format_claude_results(claude_response), name="right")
        )

        self.console.print(layout)
        self.console.print("\n[dim]Search completed![/dim]\n")


async def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Parallel Search CLI - Search with DuckDuckGo and Claude AI simultaneously"
    )
    parser.add_argument(
        'query',
        nargs='+',
        help='Search query'
    )
    parser.add_argument(
        '-n', '--num-results',
        type=int,
        default=5,
        help='Number of DuckDuckGo results to display (default: 5)'
    )

    args = parser.parse_args()
    query = ' '.join(args.query)

    try:
        cli = ParallelSearchCLI(max_results=args.num_results)
        await cli.run(query)
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        print("\nPlease set your ANTHROPIC_API_KEY environment variable:", file=sys.stderr)
        print("  export ANTHROPIC_API_KEY='your-api-key-here'", file=sys.stderr)
        sys.exit(1)
    except KeyboardInterrupt:
        print("\n\nSearch cancelled.", file=sys.stderr)
        sys.exit(0)
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    asyncio.run(main())
