using System.Runtime.InteropServices;

public class OSBridge
{
	[DllImport("__Internal")]
	public static extern void InitPano(double lat, double lon);
}
