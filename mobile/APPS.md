# Android Packages - MECE Organization

## **1. AOSP Core System (Android Open Source Project)**
Core Android system packages that are essential for the OS to function:

- android
- com.android.systemui (+ overlays)
- com.android.phone (+ overlays)
- com.android.server.telecom (+ overlays)
- com.android.shell
- com.android.bluetooth
- com.android.nfc (+ overlays)
- com.android.settings (+ overlays)
- com.android.providers.* (telephony, calendar, media, downloads, settings, contacts, userdictionary, blockednumber, partnerbookmarks)
- com.android.packageinstaller
- com.android.permissioncontroller
- com.android.externalstorage
- com.android.storagemanager
- com.android.keychain
- com.android.se
- com.android.ons
- com.android.stk (+ overlays)
- com.android.mms.service
- com.android.carrierconfig (+ overlays)
- com.android.carrierdefaultapp
- com.android.cellbroadcastreceiver
- com.android.managedprovisioning
- com.android.emergency
- com.android.location.fused
- com.android.vpndialogs
- com.android.inputdevices
- com.android.dynsystem
- com.android.companiondevicemanager
- com.android.proxyhandler
- com.android.statementservice
- com.android.traceur

## **2. AOSP Built-in Apps**
Default Android applications:

- com.android.documentsui
- com.android.htmlviewer
- com.android.certinstaller
- com.android.wallpapercropper
- com.android.wallpaper.livepicker
- com.android.wallpaperbackup
- com.android.soundpicker
- com.android.musicfx
- com.android.printspooler
- com.android.bips
- com.android.dreams.basic
- com.android.egg
- com.android.mtp
- com.android.pacprocessor
- com.android.simappdialog
- com.android.backupconfirm
- com.android.sharedstoragebackup
- com.android.calllogbackup
- com.android.localtransport
- com.android.bookmarkprovider
- com.android.smspush
- com.android.apps.tag
- com.android.facelock

## **3. Google Services & Infrastructure**
Core Google services required for GMS certification:

- com.google.android.gms (Google Play Services)
- com.google.android.gsf (Google Services Framework)
- com.android.vending (Play Store)
- com.google.android.ext.services
- com.google.android.ext.shared
- com.google.android.configupdater
- com.google.android.networkstack (+ permissionconfig)
- com.google.android.networkstack.tethering
- com.google.android.providers.media.module
- com.google.android.modulemetadata
- com.google.android.safetycenter.resources
- com.google.android.connectivity.resources
- com.google.android.wifi.resources (+ overlay, dialog)
- com.google.android.cellbroadcastservice
- com.google.android.cellbroadcastreceiver
- com.google.android.permissioncontroller
- com.google.android.packageinstaller
- com.google.android.captiveportallogin
- com.google.android.hotspot2.osulogin
- com.google.android.onetimeinitializer
- com.google.android.partnersetup
- com.google.android.setupwizard
- com.google.android.overlay.* (various config overlays)
- com.google.mainline.telemetry
- com.google.android.safetycore

## **4. Google Apps**
User-facing Google applications:

- com.google.android.youtube
- com.google.android.googlequicksearchbox
- com.google.android.apps.messaging
- com.google.android.contacts
- com.google.android.syncadapters.contacts
- com.google.android.contactkeys
- com.google.android.dialer
- com.google.android.gm (Gmail)
- com.google.android.apps.maps
- com.google.android.apps.photos
- com.google.android.calendar
- com.google.android.deskclock
- com.google.android.calculator
- com.google.android.keep
- com.google.android.apps.docs (+ editors.docs, editors.sheets)
- com.google.android.music
- com.google.android.videos
- com.google.android.apps.youtube.music
- com.google.android.apps.tachyon (Google Duo/Meet)
- com.google.android.apps.wellbeing
- com.google.android.apps.turbo
- com.google.android.apps.tasks
- com.google.android.apps.restore
- com.google.android.apps.authenticator2
- com.google.android.apps.work.oobconfig
- com.google.android.apps.walletnfcrel (Google Wallet)
- com.google.android.gms.location.history
- com.google.android.gms.pay.sidecar
- com.google.android.photopicker
- com.google.android.projection.gearhead (Android Auto)
- com.google.android.marvin.talkback
- com.google.android.tts
- com.google.android.inputmethod.latin (Gboard)
- com.google.android.feedback
- com.google.android.printservice.recommendation
- com.google.ar.core
- com.google.ar.lens

## **5. Sony/Xperia System Services**
Sony-specific system services and frameworks:

- com.sonymobile.xperiaservices (+ overlays)
- com.sonymobile.xperiasystemserver (+ overlays)
- com.sonymobile.enterprise (+ service, essservice)
- com.sonymobile.devicesecurity.service
- com.sonymobile.intelligent.* (iengine, backlight, observer, gesture)
- com.sonymobile.indeviceintelligence
- com.sonymobile.prediction
- com.sonymobile.appprediction
- com.sonymobile.telephony.extension
- com.sonymobile.telephonythermalcheck
- com.sonymobile.uiccdetection
- com.sonymobile.supplementallyservice.kddi
- com.sonymobile.wifi (+ presetnetwork)
- com.sonymobile.smartnetworkengine (+ ext)
- com.sonymobile.nfcextension.nfcextraresources
- com.sonymobile.nfc.* (clfstate, syncmigrator, remotelock.kddi, servicemenu)
- com.sonymobile.swiqisystemservice
- com.sonymobile.btidd
- com.sonymobile.gotaidd.service
- com.sonymobile.simlock.* (kddiremotesimlock, service)
- com.sonymobile.puk1locksupport
- com.sonymobile.hook
- com.sonymobile.transmitpower
- com.sonymobile.dropbox.system
- com.sonymobile.rro.* (platform overlays for bluetooth, telephony, networkstack, etc.)

## **6. Sony/Xperia Features & Enhancements**
Sony value-add features:

- com.sonymobile.displaybooster
- com.sonymobile.sunlightbooster
- com.sonymobile.whitebalance
- com.sonymobile.colorgamut
- com.sonymobile.smtofrgbc
- com.sonymobile.staminalevel
- com.sonymobile.smartcharger
- com.sonymobile.superstamina
- com.sonymobile.gameenhancer (+ browser, monitor)
- com.sonymobile.sidesenseapp
- com.sonymobile.multiwindowcontroller
- com.sonymobile.onehand
- com.sonymobile.pip
- com.sonymobile.pocketmode2
- com.sonymobile.assist_light
- com.sonymobile.smartnotification
- com.sonymobile.smartcleaner
- com.sonymobile.tvout.wifidisplay
- com.sonymobile.coverapp2
- com.sonymobile.mediavibration
- com.sonymobile.aptx.notifier
- com.sonymobile.audioutil
- com.sonymobile.dualshockmanager

## **7. Sony/Xperia Camera & Media**
Sony camera and media applications:

- com.sonyericsson.android.camera (+ overlays, 3d)
- com.sonymobile.cameracommon (+ permission)
- com.sonymobile.camera.addon.permission
- com.sonymobile.addoncamera.portraitselfie
- com.sonymobile.android.addoncamera.timeshift
- com.sonyericsson.android.addoncamera.artfilter
- com.sonymobile.cinemapro
- com.sonymobile.imageprocessor.permission
- com.sonymobile.scan3d (+ overlays)
- com.sonyericsson.album
- com.sonyericsson.photoeditor
- com.sonymobile.moviecreator
- com.sonymobile.recallplaybackphotos
- com.sonyericsson.music (+ overlays)
- com.sonymobile.xperiaxloops

## **8. Sony/Xperia UI & Launcher**
Sony user interface components:

- com.sonymobile.launcher (+ overlays)
- com.sonymobile.simplehome (+ overlays)
- com.sonymobile.wallpaperpicker
- com.sonymobile.wallpaper.light.j81
- com.sonymobile.advancedwidget.clock
- com.sonymobile.keyguard.clock
- com.sonyericsson.lockscreen.uxpnxt
- com.sonymobile.pobox (POBox keyboard)
- com.sonymobile.pobox.skin.* (gummi, easy, wood, standard)
- com.sonymobile.poboxplus.overlay
- com.sonyericsson.textinput.chinese
- com.sonymobile.android.externalkeyboard (+ jp)
- com.sonymobile.fontselector

## **9. Sony/Xperia Apps & Utilities**
Sony-branded applications:

- com.sonymobile.android.contacts (+ overlays)
- com.sonymobile.android.dialer (+ overlays)
- com.sonymobile.email (+ overlays)
- com.sonymobile.datadisclaimer (+ overlays)
- com.sonymobile.emergencymode (+ overlays)
- com.sonyericsson.settings (+ overlays)
- com.sonyericsson.setupwizard (+ overlays)
- com.sonyericsson.updatecenter (+ overlays)
- com.sonyericsson.mtp (+ extension.update, extension.fotaupdate)
- com.sonymobile.susrescheck
- com.sonymobile.demoappchecker
- com.sonymobile.apnupdater (+ overlays)

## **10. Sony/Xperia System Services (Misc)**
Other Sony system components:

- com.sonyericsson.android.servicemenu (+ overlays)
- com.sonyericsson.maintenancemenu
- com.sonyericsson.android.omacp
- com.sonyericsson.providers.cnap
- com.sonyericsson.cameraextension.permission
- com.sonyericsson.mtp.extension.update
- com.sonyericsson.soundenhancement
- com.sonyericsson.wirelessplaybackquality
- com.sonyericsson.devicemonitor
- com.sonyericsson.crashmonitor
- com.sonyericsson.psm.sysmonservice
- com.sonyericsson.idd.agent
- com.sonyericsson.usbux
- com.sonyericsson.startupflagservice
- com.sonyericsson.tetherentitlementcheck
- com.sonyericsson.android.contactpicker3
- com.sonymobile.exchange (+ overlays)

## **11. KDDI Carrier Apps & Services**
KDDI (au) carrier-specific packages:

- com.kddi.android.auhomelauncher
- com.kddi.android.auinitialsetting
- com.kddi.android.au_setting_menu
- com.kddi.android.au_wifi_connect2
- com.kddi.android.cmail
- com.kddi.android.btdun
- com.kddi.android.mamoru
- com.kddi.android.repairreceipt
- com.kddi.android.checker_android
- com.kddi.market
- com.kddi.cs.app001
- com.kddi.disasterapp
- com.kddi.extcontroldevice
- com.kddi.selfcare.* (client, external)
- com.sonymobile.kddi.settings
- com.somc.sov40.onlinemanual
- Various KDDI overlays

## **12. Qualcomm System Services**
Qualcomm chipset-related services:

- com.qualcomm.qti.* (telephonyservice, dynamicddsservice, services.systemhelper, cne, lpa, uimGbaApp, remoteSimlockAuth, devicestatisticsservice, gpudrivers.msmnile.api30)
- com.qualcomm.qcrilmsgtunnel
- com.qualcomm.location
- com.qualcomm.embms
- com.qualcomm.timeservice
- com.qualcomm.wfd.service
- com.qualcomm.uimremoteclient
- com.qualcomm.uimremoteserver
- com.qualcomm.qtil.* (aptxals, aptxalsOverlay, aptxui)
- com.qti.* (qualcomm.datastatusnotification, qualcomm.deviceinfo, dpmserviceapp)
- vendor.qti.* (iwlan, hardware.cacert.server)
- org.codeaurora.ims

## **13. FeliCa/NFC Payment Services**
Japanese mobile payment system:

- com.felicanetworks.mfw.a.boot
- com.felicanetworks.mfw.a.main
- com.felicanetworks.mfc
- com.felicanetworks.mfs
- com.felicanetworks.mfm.main

## **14. Third-Party System Services**
Pre-installed vendor services:

- com.dolby.daxappui
- com.dolby.daxservice
- com.facebook.services
- com.facebook.system
- com.facebook.appmanager
- com.amazon.appmanager

## **15. Social Media & Communication**
User communication apps:

- com.whatsapp
- jp.naver.line.android
- jp.linecorp.linemusic.android
- com.kakao.talk
- com.discord
- com.twitter.android
- com.instagram.android
- com.facebook.katana
- com.facebook.orca (Messenger)
- com.Slack
- us.zoom.videomeetings

## **16. Finance & Shopping**
Financial and e-commerce apps:

- jp.co.smbc.direct (SMBC Bank)
- jp.co.rakuten_bank.rakutenbank
- com.moneyforward.android.app
- com.smbc_card.vpass
- com.mobilesuica.msb.android
- com.amazon.mShop.android.shopping
- com.kouzoh.mercari
- com.amazon.kindle

## **17. Entertainment & Media**
Entertainment applications:

- com.spotify.music
- com.bandainamcoent.idolmaster_gakuen
- jp.coremobile.daigaku

## **18. Utilities & Productivity**
Productivity and utility apps:

- com.openai.chatgpt
- com.anthropic.claude
- com.google.android.apps.docs
- notion.id
- com.termux
- com.termux.api
- com.github.android
- com.duckduckgo.mobile.android

## **19. Japanese Services & Regional Apps**
Japan-specific services:

- jp.netstar.familysmile
- jp.co.fsi.fs1seg (1seg TV)
- jp.co.optim.oru
- jp.co.matsuyafoods.officialapp.dis

## **20. Theme & Customization Resources**
UI theming and display cutout emulation:

- com.android.theme.* (color.*, icon.*, icon_pack.*, font.*)
- com.android.internal.display.cutout.emulation.*
- com.android.internal.systemui.navbar.*
- android.stamina.* (overlays)
- Various overlay packages (android.*, com.android.*.overlay.*)

## **21. CTS & Testing**
Compatibility Test Suite packages:

- com.android.cts.priv.ctsshim
- com.android.cts.ctsshim

## **22. Partner Customizations**
Browser and device customizations:

- com.android.chrome
- com.android.partnerbrowsercustomizations.chromeHomepage (+ overlays)
- com.android.hotwordenrollment.* (xgoogle, okgoogle)
- android.autoinstalls.config.sony.xperia

---

## Summary Statistics

- **Total packages:** ~450+
- **Largest categories:** Sony/Xperia packages (~150+), Google services/apps (~70+), AOSP core (~60+)
- **Carrier-specific:** ~20 KDDI packages
- **User-installed apps:** ~30-40 (social, finance, entertainment, utilities)

---

*This organization follows MECE principles by ensuring each package belongs to exactly one category based on its primary function/owner, with no overlaps or gaps.*
