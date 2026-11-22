AppSplitVPNZH V13 — RootHide runtime localization source

Target: AppSplitVPN 0.4.8 preferences bundle, RootHide jailbreak.

This package contains Logos source, package metadata, static audit, and a GitHub Actions macOS workflow for attempting a RootHide DEB build.

IMPORTANT: source only. No compiled DEB, signing validation, injection validation, or device test is included. Read CLOUD-BUILD-GUIDE.txt before using the cloud build workflow.

The tweak is filtered to Preferences and additionally checks that the active UIViewController class belongs to AppSplitVPNPrefs.bundle (or its bundle identifier matches com.ratush.appsplitvpn.preferences). It translates exact plain UILabel, UIButton, UITextField placeholder, and UISegmentedControl strings only. It intentionally avoids UITextView, user-entered text, and attributed strings.

The original AppSplitVPNPrefs Mach-O is not modified, to avoid repeating the earlier CODESIGNING Invalid Page failure mode.
