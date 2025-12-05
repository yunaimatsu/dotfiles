# fora

## Goal
Optimize your cyberlife

## Available platforms
### Cuurently available
- YouTube
- YouTube Music
- Twitter (Currently: X)

## Initial Setup
### Add credential information to `.env`
Get the following credential information on Browser.
1. `COOKIE`: The value of the `cookie` header in the `UserTweets` request headers.
2. `BEARER_TOKEN`: The value of the `authorization` header in the `UserTweets` request headers.
3. `X_CSRF_TOKEN`: The value of the `x-csrf-token` header in the `UserTweets` request headers.
4. `GRAPHQL_API_ID`: The part of the `UserTweets` request URL between `/graphql/` and `/UserTweets`.
5. `VARIABLES`: The URL-decoded JSON object from the `variables` query parameter in the `UserTweets` request URL.
6. `FEATURES`: The URL-decoded JSON object from the `features` query parameter in the `UserTweets` request URL.
### Add favorite accounts to `following_users.json`
