#import <UIKit/UIKit.h>

// AppSplitVPN Preference bundle localization.
// This tweak is loaded only into Preferences, but translations are applied
// only while traversing a controller whose class belongs to AppSplitVPNPrefs.bundle.

static BOOL ASVZHIsTargetController(UIViewController *controller) {
    if (![controller isKindOfClass:UIViewController.class]) return NO;
    NSBundle *bundle = [NSBundle bundleForClass:[controller class]];
    NSString *path = bundle.bundlePath ?: @"";
    NSString *identifier = bundle.bundleIdentifier ?: @"";
    return [path containsString:@"AppSplitVPNPrefs.bundle"] ||
           [identifier isEqualToString:@"com.ratush.appsplitvpn.preferences"];
}

static NSString *ASVZH(NSString *s) {
    if (![s isKindOfClass:NSString.class] || s.length == 0) return s;
    static NSDictionary<NSString *, NSString *> *map;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        map = @{
            @"VPN MATRIX": @"VPN 分配矩阵",
            @"VPN MATRIX:": @"VPN 分配矩阵：",
            @"Active VPN": @"当前 VPN",
            @"Active VPNs:": @"活动 VPN：",
            @"No rules are applied yet": @"尚未应用任何规则",
            @"Could not save": @"无法保存",
            @"VPN list:": @"VPN 列表：",
            @"DIRECT list:": @"直连列表：",
            @"Primary VPN": @"主 VPN",
            @"Reserve VPNs": @"备用 VPN",
            @"Health Check": @"健康检查",
            @"Redundancy": @"故障自动切换",
            @"Always ON": @"始终开启",
            @"Round-Robin": @"轮询",
            @"Settings backup": @"设置备份",
            @"Refresh status": @"刷新状态",
            @"Export failed": @"导出失败",
            @"VPN disconnected": @"VPN 已断开",
            @"TUNNEL ONLY: only apps from the VPN list use the tunnel, all others go direct.": @"TUNNEL ONLY：只有 VPN 列表中的应用通过隧道连接，其他应用直接连接。",
            @"BYPASS: apps from the DIRECT list go direct, all others use the VPN.": @"BYPASS：直连列表中的应用直接连接，其他应用使用 VPN。",
            @"Extra: disconnecting the VPN on the lock screen, Always ON VPN and Health Check VPN Disconnect with their tuning, and the event log. Enable and the CC toggle globally stop all routing, VPN automation and checks. Saved options remain for the next activation.": @"高级功能：锁屏时断开 VPN、始终开启 VPN、VPN 断开健康检查及其调节选项，以及事件日志。关闭主开关或控制中心开关会全局停止分流、VPN 自动化和检查。已保存的选项会保留，供下次启用时使用。",
            @"MULTI VPN assigns each app to a profile in VPN MATRIX. Unassigned apps use DIRECT. Assigned apps are blocked while their VPN is unavailable. Experimental: ordinary PacketTunnel profiles only; use different VPN providers. Switching off or leaving MULTI restores the original profiles. Extra controls are hidden and inactive in this mode.": @"MULTI VPN 模式可在 VPN 分配矩阵中为每个应用指定配置。未分配的应用使用 DIRECT。指定应用在对应 VPN 不可用时会被阻止联网。实验功能：仅支持普通 PacketTunnel 配置，建议使用不同的 VPN 服务提供商。关闭此功能或退出 MULTI 模式后，将恢复原始配置。此模式下高级控制项会隐藏并停用。",
            @"Preserve DoT/DoH: DIRECT apps bypass only the VPN and use enabled system encrypted DNS profiles and their domain rules. Off by default; BYPASS only. Conditional on-demand DNS profiles are not overridden. Built-in app DNS is not changed. Reopen the app after toggling.": @"保留 DoT/DoH：DIRECT 应用仅绕过 VPN，仍使用系统中已启用的加密 DNS 配置及其域名规则。默认关闭，仅适用于 BYPASS 模式。不会覆盖条件式按需 DNS 配置，也不会更改应用内置 DNS。切换此选项后请重新打开应用。",
            @"Export/import includes all tweak settings, app lists, VPN MATRIX, primary VPN and ordered reserves. Missing apps and profiles are skipped. Only profile identifiers and display metadata are included; VPN keys and credentials stay in their VPN apps.": @"导出/导入内容包括所有插件设置、应用列表、VPN 分配矩阵、主 VPN 和按顺序排列的备用 VPN。不存在的应用和配置将被跳过。文件仅包含配置标识符和显示信息；VPN 密钥及凭据仍保留在各自的 VPN 应用中。",
            @"Health Check VPN Disconnect: while the VPN is connected, periodically checks that traffic passes through the tunnel to a public resource. After several failures in a row it disconnects the broken VPN; together with Always ON the VPN then reconnects at once. No checks run without a VPN, without a network, or on the locked screen when \"Disconnect VPN on LS\" is on.": @"VPN 断开健康检查：VPN 连接期间，定期访问公共资源，以确认流量确实通过隧道传输。连续多次检查失败后，会断开故障 VPN；如果同时启用了始终开启，VPN 随即会尝试重新连接。未连接 VPN、没有网络，或启用“锁屏时断开 VPN”且屏幕已锁定时，不会执行检查。",
            @"Redundancy is available only in BYPASS and TUNNEL ONLY. Enabling it enables Health Check and Always ON. Reserve profiles are tried in selection order (Round-Robin) or in a random order without repeats. If every reserve fails, VPN, Redundancy and Always ON are stopped until you intervene.": @"故障自动切换仅适用于 BYPASS 和 TUNNEL ONLY 模式。启用后会同时启用健康检查和始终开启。备用配置将按选择顺序（轮询）或随机且不重复的顺序依次尝试。如果所有备用配置均失败，VPN、故障自动切换和始终开启都会停止，等待你手动处理。",
            @"Without Redundancy, the same failure threshold also limits consecutive reconnect cycles with no successful check. Reaching it disables Health Check and Always ON. A successful check breaks the failed-cycle sequence.": @"未启用故障自动切换时，相同的失败阈值也会限制连续重连但始终未通过检查的次数。达到阈值后，健康检查和始终开启将被关闭。检查成功后，连续失败计数会清零。",
            @"The VPN profile selected in iOS, its connection state, the latest Health Check result and the extra options that are on. Updates automatically.": @"显示 iOS 中选定的 VPN 配置、连接状态、最近一次健康检查结果，以及当前已启用的高级选项。内容会自动更新。",
            @"The event log keeps the last 300 events: VPN connections and disconnections, Health Check results, reconnects and screen locks.": @"事件日志最多保留最近 300 条记录，包括 VPN 连接与断开、健康检查结果、重新连接及屏幕锁定事件。",
            @"Health Check: VPN disconnected": @"健康检查：VPN 已断开",
            @"Disconnect VPN on LS": @"锁屏时断开 VPN",
            // Exact additional labels and status strings verified in the original Mach-O string table.
            @"App lists": @"应用列表",
            @"Event log": @"事件日志",
            @"Export": @"导出",
            @"Import": @"导入",
            @"No events yet": @"暂无事件",
            @"Clear the event log?": @"确定清空事件日志吗？",
            @"Profile unavailable": @"配置不可用",
            @"Profile expired": @"配置已过期",
            @"VPN profile": @"VPN 配置",
            @"Profile:": @"配置：",
            @"Profiles order": @"配置顺序",
            @"Tuning: Health Check": @"调节：健康检查",
            @"Health Check target": @"健康检查目标",
            @"Public IP service: an HTTP(S) URL returning Cloudflare trace, JSON or plain IP. Reset tuning restores defaults for all tuning sections; app lists and VPN selections remain saved.": @"公网 IP 服务：返回 Cloudflare trace、JSON 或纯 IP 地址的 HTTP(S) URL。重置调节选项会恢复所有调节分区的默认值；应用列表和 VPN 选择会保留。",
            @"Settings applied. Unavailable or invalid items skipped: %lu. VPN profiles are matched by UUID or a unique app + profile name. VPN credentials are not imported.": @"设置已应用。已跳过不可用或无效项目：%lu。VPN 配置通过 UUID 或唯一的应用名称与配置名称匹配。不会导入 VPN 凭据。",
            @"The VPN profile selected in iOS Settings and the icon of the app it belongs to. Built-in iOS VPN profiles (IKEv2, IPsec) have no app and show a shield.": @"显示 iOS 设置中选定的 VPN 配置及其所属应用图标。内置 iOS VPN 配置（IKEv2、IPsec）没有所属应用，因此显示盾牌图标。",
            @"All connected MULTI profiles, with the icon of each VPN app. The badge VPN:N counts connected profiles, not assigned apps.": @"显示所有已连接的 MULTI 配置及各 VPN 应用的图标。VPN:N 标记统计的是已连接配置数量，而不是已分配的应用数量。",
            @"MULTI public IP is checked separately through each connected profile using an assigned app's native routing policy. The connection's local address must match that profile's tunnel; otherwise it is shown as unavailable. Checks run on connection, page opening and Refresh status, not continuously. The default service has a numeric Cloudflare fallback if DNS is unavailable.": @"MULTI 公网 IP 会分别通过每个已连接配置进行检查，并使用已分配应用的原生路由策略。连接的本地地址必须与该配置的隧道匹配，否则会显示为不可用。检查会在连接成功、打开页面及点击“刷新状态”时执行，不会持续运行。如果 DNS 不可用，默认服务会使用 Cloudflare 数字地址作为备用。",
            @"Always ON VPN": @"始终开启 VPN",
            @"Keep VPN for PiP/music on LS": @"锁屏时为画中画/音乐保留 VPN",
            @"Colored [VPN1/2] badge": @"彩色 [VPN1/2] 标记",
            @"Colored [VPN1/2] badge off: keep the native VPN indicator, without custom text, tint or extra badges.": @"关闭彩色 [VPN1/2] 标记：保留系统原生 VPN 指示，不添加自定义文字、着色或额外标记。",
            @"Check method": @"检查方式",
            @"Choose a filter": @"选择筛选条件",
            @"Don't group": @"不分组",
            @"Failures before OFF": @"关闭前的失败次数",
            @"Group by": @"分组依据",
            @"Groups order": @"分组顺序",
            @"Installed first": @"已安装应用优先",
            @"Installed last": @"已安装应用靠后",
            @"Interval, s": @"间隔（秒）",
            @"Invalid settings file": @"设置文件无效",
            @"Invalid value, the previous one is kept.": @"数值无效，保留之前的设置。",
            @"LS delay, s": @"锁屏延迟（秒）",
            @"List options": @"列表选项",
            @"No VPN": @"无 VPN",
            @"No category": @"无类别",
            @"Not connected": @"未连接",
            @"Not selected": @"未选择",
            @"OK %@ %@": @"正常 %@ %@",
            @"Public IP %lu:": @"公网 IP %lu：",
            @"Public IP:": @"公网 IP：",
            @"Redundancy Switch Algorithm": @"故障切换算法",
            @"Reset tuning": @"重置调节选项",
            @"Routing log": @"路由日志",
            @"Screen locked": @"屏幕已锁定",
            @"Screen unlocked": @"屏幕已解锁",
            @"Selected / not selected": @"已选中 / 未选中",
            @"Selected / unselected": @"已选中 / 未选中",
            @"Selected first": @"已选项优先",
            @"Selected last": @"已选项靠后",
            @"System selection (auto)": @"系统选择（自动）",
            @"The global Enable switch and CC toggle suspend all options while off; their saved settings remain.": @"全局启用开关和控制中心开关关闭时，会暂停所有选项；已保存的设置仍会保留。",
            @"The two lists are independent; only the list of the current mode is applied.": @"两个列表相互独立；仅应用当前模式对应的列表。",
            @"Timeout, s": @"超时时间（秒）",
            @"Tuning: General": @"调节：常规",
            @"Tuning: Lock screen": @"调节：锁屏",
            @"Tuning: Redundancy": @"调节：故障自动切换",
            @"User / system": @"用户 / 系统",
            @"User apps first": @"用户应用优先",
            @"User apps last": @"用户应用靠后",
            @"VPN app": @"VPN 应用",
            @"VPN connected": @"VPN 已连接",
            @"VPN is off": @"VPN 已关闭",
            @"Whole number from %@ to %@": @"请输入 %@ 到 %@ 之间的整数",
            @"no network": @"无网络",
            @"no tunnel": @"无隧道",
            @"not connected": @"未连接",
            @"service stopped": @"服务已停止",
            @"Import skips missing apps and VPN profiles and applies the remaining settings.": @"导入时会跳过缺失的应用和 VPN 配置，并应用其余设置。",
            @"Settings imported": @"设置已导入",
            @"\"No link\" means the VPN is connected but the last checks failed.": @"“无连通性”表示 VPN 已连接，但最近的检查未通过。",
            @"After changing the rules, reopen the affected apps: already open connections keep their old route.": @"更改规则后，请重新打开受影响的应用：已经建立的连接仍会沿用旧路由。",
        };
    });
    return map[s] ?: s;
}

static void ASVZHTranslateView(UIView *view) {
    if ([view isKindOfClass:UILabel.class]) {
        UILabel *label = (UILabel *)view;
        // Do not flatten NSAttributedString content: replacing the whole string can destroy per-range styling.
        if (!label.attributedText) {
            NSString *translated = ASVZH(label.text);
            if (label.text && ![translated isEqualToString:label.text]) label.text = translated;
        }
    } else if ([view isKindOfClass:UIButton.class]) {
        UIButton *button = (UIButton *)view;
        for (NSNumber *stateNumber in @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled), @(UIControlStateSelected), @(UIControlStateFocused)]) {
            UIControlState state = stateNumber.unsignedIntegerValue;
            // Keep attributed button titles intact; translate plain titles only.
            if ([button attributedTitleForState:state]) continue;
            NSString *title = [button titleForState:state];
            NSString *translatedTitle = ASVZH(title);
            if (title.length && ![translatedTitle isEqualToString:title]) [button setTitle:translatedTitle forState:state];
        }
    } else if ([view isKindOfClass:UITextField.class]) {
        UITextField *field = (UITextField *)view;
        // Preserve attributed placeholders and all user-entered text.
        if (!field.attributedPlaceholder) {
            NSString *translatedPlaceholder = ASVZH(field.placeholder);
            if (field.placeholder && ![translatedPlaceholder isEqualToString:field.placeholder]) field.placeholder = translatedPlaceholder;
        }
    } else if ([view isKindOfClass:UITextView.class]) {
        // Intentionally leave UITextView untouched: it may contain editable text.
    } else if ([view isKindOfClass:UISegmentedControl.class]) {
        UISegmentedControl *segments = (UISegmentedControl *)view;
        for (NSUInteger i = 0; i < segments.numberOfSegments; i++) {
            NSString *title = [segments titleForSegmentAtIndex:i];
            NSString *translated = ASVZH(title);
            if (title.length && ![translated isEqualToString:title]) [segments setTitle:translated forSegmentAtIndex:i];
        }
    }
    for (UIView *subview in view.subviews) ASVZHTranslateView(subview);
}

%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    if (ASVZHIsTargetController(self)) ASVZHTranslateView(self.view);
}
- (void)viewDidLayoutSubviews {
    %orig;
    if (ASVZHIsTargetController(self)) ASVZHTranslateView(self.view);
}
%end
