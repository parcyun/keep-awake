# Keeps the display awake and sends an F15 press/release every four minutes.
$createdNew = $false
$mutex = New-Object System.Threading.Mutex($true, 'Local\KeepAwake', [ref]$createdNew)

if (-not $createdNew) { exit 0 }

Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class DisplayAwake
{
    [DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);

    [StructLayout(LayoutKind.Sequential)]
    public struct INPUT
    {
        public uint type;
        public KEYBDINPUT ki;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct KEYBDINPUT
    {
        public ushort wVk;
        public ushort wScan;
        public uint dwFlags;
        public uint time;
        public IntPtr dwExtraInfo;
    }

    [DllImport("user32.dll", SetLastError = true)]
    public static extern uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

    public static void SendQuietActivity()
    {
        const ushort VK_F15 = 0x7E;
        const uint KEYEVENTF_KEYUP = 0x0002;
        INPUT[] inputs = new INPUT[2];
        inputs[0].type = 1;
        inputs[0].ki.wVk = VK_F15;
        inputs[1].type = 1;
        inputs[1].ki.wVk = VK_F15;
        inputs[1].ki.dwFlags = KEYEVENTF_KEYUP;
        SendInput(2, inputs, Marshal.SizeOf(typeof(INPUT)));
    }
}
'@

$ES_CONTINUOUS = [uint32]2147483648
$ES_SYSTEM_REQUIRED = [uint32]1
$ES_DISPLAY_REQUIRED = [uint32]2

try {
    while ($true) {
        [void][DisplayAwake]::SetThreadExecutionState([uint32]($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED -bor $ES_DISPLAY_REQUIRED))
        [DisplayAwake]::SendQuietActivity()
        Start-Sleep -Seconds 240
    }
}
finally {
    [void][DisplayAwake]::SetThreadExecutionState($ES_CONTINUOUS)
    $mutex.ReleaseMutex()
    $mutex.Dispose()
}
