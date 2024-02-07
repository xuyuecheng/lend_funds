package com.fund.funds.lucky.go.loan;


import static android.content.Context.TELEPHONY_SERVICE;
import static android.telephony.TelephonyManager.NETWORK_TYPE_1xRTT;
import static android.telephony.TelephonyManager.NETWORK_TYPE_CDMA;
import static android.telephony.TelephonyManager.NETWORK_TYPE_EDGE;
import static android.telephony.TelephonyManager.NETWORK_TYPE_EVDO_0;
import static android.telephony.TelephonyManager.NETWORK_TYPE_EVDO_A;
import static android.telephony.TelephonyManager.NETWORK_TYPE_EVDO_B;
import static android.telephony.TelephonyManager.NETWORK_TYPE_GPRS;
import static android.telephony.TelephonyManager.NETWORK_TYPE_HSDPA;
import static android.telephony.TelephonyManager.NETWORK_TYPE_HSPA;
import static android.telephony.TelephonyManager.NETWORK_TYPE_HSPAP;
import static android.telephony.TelephonyManager.NETWORK_TYPE_IDEN;
import static android.telephony.TelephonyManager.NETWORK_TYPE_LTE;
import static android.telephony.TelephonyManager.NETWORK_TYPE_NR;
import static android.telephony.TelephonyManager.NETWORK_TYPE_UMTS;

import android.Manifest;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.net.ConnectivityManager;
import android.os.Build;
import android.os.Environment;
import android.os.StatFs;
import android.os.SystemClock;
import android.provider.Settings;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.CellInfoGsm;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.CellSignalStrengthCdma;
import android.telephony.CellSignalStrengthGsm;
import android.telephony.CellSignalStrengthLte;
import android.telephony.CellSignalStrengthWcdma;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.WindowManager;

import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;
import java.util.regex.Pattern;

public class DriverInfoUtil {
    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    public static String getAndroidID(Context context) {
        try {
            String androidID = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ANDROID_ID);
            //LogUtil.e("androidID: " + androidID);
            return androidID;
        } catch (Exception e) {
            return null;
        }
    }

    public static String getPhone(Context context){
        String tel1 = "";
        try {
            TelephonyManager tm=(TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            @SuppressLint("MissingPermission")
            String tel = tm.getLine1Number(); //
            tel1 = tel;
        }catch (Exception e) {

        }
        if (TextUtils.isEmpty(tel1)) {
            try {
                if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
                    SubscriptionManager subscriptionManager = null;
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                        subscriptionManager = SubscriptionManager.from(context);
                        @SuppressLint("MissingPermission") List<SubscriptionInfo> subscriptionInfoList = subscriptionManager.getActiveSubscriptionInfoList();
                        if (subscriptionInfoList != null && subscriptionInfoList.size() > 0) {
                            for (SubscriptionInfo info : subscriptionInfoList) {
                                if (!TextUtils.isEmpty(info.getNumber())) {
                                    tel1 = info.getNumber();
                                    break;
                                }
                            }
                        }
                    }

                }
            } catch (Exception e) {

            }
        }

        if (TextUtils.isEmpty(tel1)) {
            try {
                TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
                Class telephonyClass = Class.forName(telephonyManager.getClass().getName());
                Method getITelephonyMethod = telephonyClass.getDeclaredMethod("getITelephony");
                getITelephonyMethod.setAccessible(true);
                Object iTelephony = getITelephonyMethod.invoke(telephonyManager);
                Class<?> iTelephonyClass = Class.forName(iTelephony.getClass().getName());
                Method getSubscriberIdMethod = iTelephonyClass.getDeclaredMethod("getSubscriberId");
                getSubscriberIdMethod.setAccessible(true);
                String subscriberId = (String) getSubscriberIdMethod.invoke(iTelephony);
                if (subscriberId != null && subscriberId.length() > 3) {
                    tel1 = subscriberId.substring(3);
                }
            } catch (Exception e) {

            }
        }

        if (TextUtils.isEmpty(tel1)) {
            try {
                TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
                String operatorNumeric = telephonyManager.getSimOperator();
                if (operatorNumeric != null && operatorNumeric.length() > 0) { //
                    Class<?> c = Class.forName("android.os.SystemProperties");
                    Method get = c.getMethod("get", String.class);
                    String phoneNumber = (String) get.invoke(c, "ro.cdma.icc_line1");
                    if (phoneNumber != null && phoneNumber.length() > 0) {
                        tel1 = phoneNumber;
                    }
                }
            } catch (Exception e) {

            }
        }

        return tel1;
    }

    public static String getPhoneType(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            String phoneTypeStr = "";
            int phoneType = tm.getPhoneType();
            switch (phoneType) {
                case TelephonyManager.PHONE_TYPE_CDMA:
                    phoneTypeStr = "CDMA";
                    break;
                case TelephonyManager.PHONE_TYPE_GSM:
                    phoneTypeStr = "GSM";
                    break;
                case TelephonyManager.PHONE_TYPE_SIP:
                    phoneTypeStr = "SIP";
                    break;
                case TelephonyManager.PHONE_TYPE_NONE:
                    phoneTypeStr = "None";
                    break;
            }
            return phoneTypeStr;
        } catch (Exception e) {
            return null;
        }
    }

    public static String getMNC(Context context) {
        try {
            Configuration cfg = context.getResources().getConfiguration();
            return cfg.mnc + "";
        } catch (Exception e) {
            return null;
        }
    }

    public static String getMCC(Context context) {
        try {
            Configuration cfg = context.getResources().getConfiguration();
            return cfg.mcc + "";
        } catch (Exception e) {
            return null;
        }
    }

    public static String getLocalDNS() {
        try {
            Process cmdProcess = null;
            BufferedReader reader = null;
            String dnsIP = "";
            try {
                cmdProcess = Runtime.getRuntime().exec("getprop net.dns1");
                reader = new BufferedReader(new InputStreamReader(cmdProcess.getInputStream()));
                dnsIP = reader.readLine();
                return dnsIP;
            } catch (IOException e) {
                return null;
            } finally {
                try {
                    reader.close();
                } catch (IOException e) {
                }
                cmdProcess.destroy();
            }
        } catch (Exception e) {
            return null;
        }
    }

    public static String getOsLanguage(Context context) {
        try {
            Locale locale = context.getResources().getConfiguration().locale;
            String language = locale.getLanguage();
            return language;
        } catch (Exception e) {
            return null;
        }
    }

    @SuppressLint("MissingPermission")
    public static String getDriverIMIE(Context context) {
        try {
            boolean flag = checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE);
            if (!flag) {
                return getTelephonyManager(context).getDeviceId();
            }
            return "";
        } catch (Exception e) {
            return "";
        }
    }

    public static boolean checkSelfPermission(Context context, String permission) {
        if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
            return true;

        } else {
            return false;
        }
    }

    private static TelephonyManager telephonyManager;
    private static TelephonyManager getTelephonyManager(Context context) {
        if (telephonyManager == null) {
            telephonyManager = (TelephonyManager) context.getSystemService(TELEPHONY_SERVICE);
        }
        return telephonyManager;
    }

    public static String getNetworkOperator(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            return tm.getNetworkOperator();
        } catch (Exception e) {
            return null;
        }
    }

    public static String getNetworkType(Context context) {
        try {
            TelephonyManager teleMan = (TelephonyManager)
                    context.getSystemService(Context.TELEPHONY_SERVICE);
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                @SuppressLint("MissingPermission") int networkType = teleMan.getNetworkType();
                switch (networkType) {
                    case TelephonyManager.NETWORK_TYPE_1xRTT:
                        return "1xRTT";
                    case TelephonyManager.NETWORK_TYPE_CDMA:
                        return "CDMA";
                    case NETWORK_TYPE_EDGE:
                        return "EDGE";
                    case TelephonyManager.NETWORK_TYPE_EVDO_B:
                        return "EVDO rev. B";
                    case TelephonyManager.NETWORK_TYPE_GPRS:
                        return "GPRS";
                    case TelephonyManager.NETWORK_TYPE_HSDPA:
                        return "HSDPA";
                    case TelephonyManager.NETWORK_TYPE_HSPA:
                        return "HSPA";
                    case TelephonyManager.NETWORK_TYPE_HSPAP:
                        return "HSPA+";
                    case TelephonyManager.NETWORK_TYPE_EHRPD:
                        return "eHRPD";
                    case TelephonyManager.NETWORK_TYPE_HSUPA:
                        return "HSUPA";
                    case TelephonyManager.NETWORK_TYPE_IDEN:
                        return "iDen";
                    case TelephonyManager.NETWORK_TYPE_LTE:
                        return "LTE";
                    case TelephonyManager.NETWORK_TYPE_EVDO_0:
                        return "EVDO rev. 0";
                    case TelephonyManager.NETWORK_TYPE_EVDO_A:
                        return "EVDO rev. A";
                    case TelephonyManager.NETWORK_TYPE_UMTS:
                        return "UMTS";
                    case TelephonyManager.NETWORK_TYPE_UNKNOWN:
                        return "Unknown";
                }
            }
        } catch (Exception e) {
        }

        return "Unknown";
    }

    public static String getNetworkOperatorName(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            return tm.getNetworkOperatorName();
        } catch (Exception e) {
            return null;
        }
    }

    public static String getTimeZoneId() {
        try {
            String timeZoneId = TimeZone.getDefault().getID();
            return timeZoneId;
        } catch (Exception e) {
            return null;
        }
    }

    public static String getISO3Language(Context context) {
        try {
            Locale locale = context.getResources().getConfiguration().locale;
            String language = locale.getISO3Language();
            return language;
        } catch (Exception e) {
            return null;
        }
    }

    public static String getLocaleDisplayLanguage() {
        try {
            String displayLanguage = Locale.getDefault().getDisplayLanguage();
            return displayLanguage;
        } catch (Exception e) {
            return null;
        }
    }

    public static String getISO3Country(Context context) {
        try {
            Locale locale = context.getResources().getConfiguration().locale;
            String country = locale.getISO3Country();
            return country;
        } catch (Exception e) {
            return null;
        }
    }

    @SuppressLint("MissingPermission")
    public static String getImsi(Context context) {
        try {
            if (!checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE)) {
                TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
                return tm.getSubscriberId();
            }
            return "";
        } catch (Exception e) {
            return "";
        }
    }

    public static String getDeviceName() {
        try {
            return Build.DEVICE;
        } catch (Exception e) {
            return "";
        }

    }

    public static String getBrand() {
        try {
            String brand = Build.BRAND;
            return brand;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public static String getDevicePro() {
        try {
            return Build.PRODUCT;
        } catch (Exception e) {
            return "";
        }
    }

    public static String getModel() {
        try {
            String model = Build.MODEL;
            return model;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public static String getOperatingSystemVersion() {
        try {
            return Build.VERSION.RELEASE;
        } catch (Exception e) {
            return "";
        }

    }

    public static String cpuNameGet() {
        try {
            FileReader fileReader = new FileReader("/proc/cpuinfo");
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            String line = bufferedReader.readLine();
            String[] cpuInfoArray = line.split(":\\s+", 2);
            return cpuInfoArray[1];

        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";

    }

    public static String getSoftwareDevelopmentKitVersion() {
        try {
            String sdkVersion = Build.VERSION.SDK;
            return sdkVersion;
        } catch (Exception e) {
            return "";
        }
    }

    public static String SmMySerialNumber() {
        String serial = getSystemProperty("ro.serialno", "");
        if (serial.isEmpty()) {
            serial = getSystemProperty("ril.serialnumber", "unknown");
        }
        return serial;
    }

    public static String getSystemProperty(String propertyName, String defaultValue) {
        String propertyValue = defaultValue;
        try {
            Class<?> systemPropertiesClass = Class.forName("java.lang.System");
            Method getPropertyMethod = systemPropertiesClass.getMethod("getProperty", String.class, String.class);
            propertyValue = (String) getPropertyMethod.invoke(null, propertyName, defaultValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return propertyValue;
    }

    public static String getPhysicalSize(Context context) {
        try {
            WindowManager windowManager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            Display defaultDisplay = windowManager.getDefaultDisplay();
            DisplayMetrics displayMetrics = new DisplayMetrics();
            defaultDisplay.getMetrics(displayMetrics);
            return Double.toString(Math.sqrt(Math.pow((double) (((float) displayMetrics.heightPixels) / displayMetrics.ydpi), 2.0d) + Math.pow((double) (((float) displayMetrics.widthPixels) / displayMetrics.xdpi), 2.0d)));
        } catch (Exception e) {
            return null;
        }
    }

    public static long getTotalInternalMemorySize() {
        try {
            File path = Environment.getDataDirectory();
            StatFs stat = new StatFs(path.getPath());
            long blockSize = stat.getBlockSize();
            long totalBlocks = stat.getBlockCount();
            return totalBlocks * blockSize;
        } catch (Exception e) {
            return 0;
        }
    }

    public static long getAvailableExternalStorageSize() {
        try {
            File path = Environment.getExternalStorageDirectory();
            StatFs statFs = new StatFs(path.getPath());
            return statFs.getAvailableBlocksLong() * statFs.getBlockSizeLong();
        } catch (Exception e) {
            return 0;
        }
    }

    public static long getTotalExternalMemorySize() {
        try {
            File path = Environment.getExternalStorageDirectory();
            StatFs stat = new StatFs(path.getPath());
            long blockSize = stat.getBlockSize();
            long totalBlocks = stat.getBlockCount();
            return totalBlocks * blockSize;
        } catch (Exception e) {
            return 0;
        }
    }

    public static long getAvailableExternalMemorySize() {
        try {
            File path = Environment.getExternalStorageDirectory();
            StatFs stat = new StatFs(path.getPath());
            long blockSize = stat.getBlockSize();
            long availableBlocks = stat.getAvailableBlocks();
            return availableBlocks * blockSize;
        } catch (Exception e) {
            return 0;
        }
    }

    public static Map getSDInfo() {
        try {
            if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
                Map jsonObject = new HashMap();
                File path = Environment.getExternalStorageDirectory();
                StatFs sf = new StatFs(path.getPath());
                // SMT_RANDOM_SORT_BEGIN
                long blockSize = sf.getBlockSize();
                long totalBlock = sf.getBlockCount();
                long availableBlock = sf.getAvailableBlocks();
                long totalLong = totalBlock * blockSize;
                long freeLong = availableBlock * blockSize;
                long useLong = totalLong - freeLong;
                // SMT_RANDOM_SORT_END
                // SMT_RANDOM_SORT_BEGIN
                jsonObject.put("totalSize", totalLong);
                jsonObject.put("freeSize", freeLong);
                jsonObject.put("useSize", useLong);
                // SMT_RANDOM_SORT_END
                return jsonObject;
            } else if (Environment.getExternalStorageState().equals(Environment.MEDIA_REMOVED)) {
                return null;
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    public static String radioVersion() {
        try {
            return Build.getRadioVersion();
        } catch (Exception e) {
            return "";
        }

    }

    public static String getSimCountryIso(Context context) {
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            return tm.getSimCountryIso();
        } catch (Exception e) {
            return null;
        }
    }

    public static Boolean isSimCardReady(Context context) {
        try {
            TelephonyManager telMgr = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            int simState = telMgr.getSimState();
            switch (simState) {
                case TelephonyManager.SIM_STATE_ABSENT:
                    break;
                case TelephonyManager.SIM_STATE_NETWORK_LOCKED:
                    break;
                case TelephonyManager.SIM_STATE_PIN_REQUIRED:
                    // do something
                    break;
                case TelephonyManager.SIM_STATE_PUK_REQUIRED:
                    // do something
                    break;
                case TelephonyManager.SIM_STATE_READY:
                    return true;
                case TelephonyManager.SIM_STATE_UNKNOWN:
                    // do something
                    break;
            }
            return false;
        } catch (Exception e) {
            return null;
        }
    }

    public static boolean isMobileData(Context context) {
        boolean mobileDataEnabled = false; // Assume disabled

        try {
            ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            Class cmClass = Class.forName(cm.getClass().getName());
            Method method = cmClass.getDeclaredMethod("getMobileDataEnabled");
            method.setAccessible(true); // Make the method callable
            // get the setting for "mobile data"
            mobileDataEnabled = (Boolean) method.invoke(cm);
        } catch (Exception e) {
            // Some problem accessible private API
            // TODO do whatever error handling you want here
        }
        return mobileDataEnabled;
    }

    public static String getDataNetworkType(Context context) {
        String ret = null;
        try {
            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(TELEPHONY_SERVICE);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                switch (telephonyManager.getDataNetworkType()) {
                    // SMT_RANDOM_SORT_BEGIN
                    case NETWORK_TYPE_EDGE:
                    case NETWORK_TYPE_GPRS:
                    case NETWORK_TYPE_CDMA:
                    case NETWORK_TYPE_IDEN:
                    case NETWORK_TYPE_1xRTT:
                        // SMT_RANDOM_SORT_END
                        ret = "2G";
                        break;
                    // SMT_RANDOM_SORT_BEGIN
                    case NETWORK_TYPE_UMTS:
                    case NETWORK_TYPE_HSDPA:
                    case NETWORK_TYPE_HSPA:
                    case NETWORK_TYPE_HSPAP:
                    case NETWORK_TYPE_EVDO_0:
                    case NETWORK_TYPE_EVDO_A:
                    case NETWORK_TYPE_EVDO_B:
                        // SMT_RANDOM_SORT_END
                        ret = "3G";
                        break;
                    case NETWORK_TYPE_LTE:
                        ret = "4G";
                        break;
                    case NETWORK_TYPE_NR:
                        ret = "5G";
                        break;
                    default:
                        ret = "Unknown";
                }
            }
        } catch (Exception e) {
        }
        return ret;
    }

    public static String getRamTotalSize(Context context) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        ActivityManager.MemoryInfo memoryInfo = new ActivityManager.MemoryInfo();
        activityManager.getMemoryInfo(memoryInfo);
        return memoryInfo.totalMem + "";

    }

    public static String getRamAvailSize(Context context) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        ActivityManager.MemoryInfo memoryInfo = new ActivityManager.MemoryInfo();
        activityManager.getMemoryInfo(memoryInfo);
        return memoryInfo.availMem + "";
    }

    public static String getRootDirectory() {
        return Environment.getExternalStorageDirectory().getAbsolutePath();

    }

    public static String getExternalStorageDirectory() {
        return System.getenv("SECONDARY_STORAGE");
    }

    public static List<String> getSystemPhotoList(Context context) {
        List<String> result = new ArrayList<String>();
        return result;
    }

    public static boolean isRooted() {

        try {
            String buildTags = Build.TAGS;
            if (buildTags != null && buildTags.contains("test-keys")) {
                return true;
            }

            String[] paths = {"/system/app/Superuser.apk", "/sbin/su", "/system/bin/su",
                    "/system/xbin/su", "/data/local/xbin/su", "/data/local/bin/su",
                    "/system/sd/xbin/su",
                    "/system/bin/failsafe/su", "/data/local/su", "/su/bin/su"};
            for (String path : paths) {
                if (new File(path).exists()) return true;
            }

            Process process = null;
            try {
                process = Runtime.getRuntime().exec(new String[]{"/system/xbin/which", "su"});
                BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
                if (in.readLine() != null) return true;
                return false;
            } catch (Throwable t) {
                return false;
            } finally {
                if (process != null) process.destroy();
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isEmulator() {
        try {
            return Build.FINGERPRINT.startsWith("generic")
                    || Build.FINGERPRINT.toLowerCase().contains("vbox")
                    || Build.FINGERPRINT.toLowerCase().contains("test-keys")
                    || Build.MODEL.contains("google_sdk")
                    || Build.MODEL.contains("sdk")
                    || Build.MODEL.contains("Emulator")
                    || Build.MANUFACTURER.contains("Genymotion")
                    || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
                    || "google_sdk".equals(Build.PRODUCT);
        } catch (Exception e) {
            return false;
        }
    }

    public static String getKeyboard(Context context) {
        try {
            Configuration cfg = context.getResources().getConfiguration();
            return cfg.keyboard + "";
        } catch (Exception e) {
            return null;
        }
    }

    public static int CpuNumCoresGetfj() {
        File directory = new File("/sys/devices/system/cpu/");
        File[] files = directory.listFiles((dir, name) -> Pattern.matches("cpu[0-9]", name));
        if (files != null) {
            return files.length;
        } else {
            return 1;
        }
    }

    public static float[] getMemory(Context context) {
        try {
            float appMaxMemory = (float) (Runtime.getRuntime().maxMemory() * 1.0 / (1024 * 1024));
            float appAvailableMemory = (float) (Runtime.getRuntime().totalMemory() * 1.0 / (1024 * 1024));
            float appFreeMemory = (float) (Runtime.getRuntime().freeMemory() * 1.0 / (1024 * 1024));
            float[] memoryList = {appMaxMemory, appAvailableMemory, appFreeMemory};
            return memoryList;
        } catch (Exception e) {
            float[] memoryList = {0, 0, 0};
            return memoryList;
        }
    }

    public static long[] getOsTime(Context context) {
        try {
            long[] times = {SystemClock.elapsedRealtime(), SystemClock.uptimeMillis()};
            return times;
        } catch (Exception e) {
            long[] times = {0, 0};
            return times;
        }
    }

    public static int[] getBattery(Context context) {
        try {
            Intent batteryInfoIntent = context.getApplicationContext().registerReceiver(null,
                    new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            int level = batteryInfoIntent.getIntExtra("level", 0);
            int max = batteryInfoIntent.getIntExtra("scale", 100);
            int[] batterys = {max, level};
            return batterys;
        } catch (Exception e) {
            int[] batterys = {0, 0};
            return batterys;
        }
    }

    @SuppressLint("MissingPermission")
    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR2)
    public static Map getCellInfo(Context context) {
        Map jsonObject = new HashMap();
        if (!checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION)) {
            int dbm = -1;
            int cid = -1;
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            List<CellInfo> cellInfoList;
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
                cellInfoList = tm.getAllCellInfo();
                if (null != cellInfoList) {
                    for (CellInfo cellInfo : cellInfoList) {
                        if (cellInfo instanceof CellInfoGsm) {
                            CellSignalStrengthGsm cellSignalStrengthGsm = ((CellInfoGsm) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthGsm.getDbm();
                            cid = ((CellInfoGsm) cellInfo).getCellIdentity().getCid();
                        } else if (cellInfo instanceof CellInfoCdma) {
                            CellSignalStrengthCdma cellSignalStrengthCdma = ((CellInfoCdma) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthCdma.getDbm();
                            cid = ((CellInfoCdma) cellInfo).getCellIdentity().getBasestationId();
                        } else if (cellInfo instanceof CellInfoWcdma) {
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                                CellSignalStrengthWcdma cellSignalStrengthWcdma = ((CellInfoWcdma) cellInfo).getCellSignalStrength();
                                dbm = cellSignalStrengthWcdma.getDbm();
                                cid = ((CellInfoWcdma) cellInfo).getCellIdentity().getCid();
                            }
                        } else if (cellInfo instanceof CellInfoLte) {
                            CellSignalStrengthLte cellSignalStrengthLte = ((CellInfoLte) cellInfo).getCellSignalStrength();
                            dbm = cellSignalStrengthLte.getDbm();
                            cid = ((CellInfoLte) cellInfo).getCellIdentity().getCi();
                        }
                    }
                }
            }
            jsonObject.put("dbm", dbm);
            jsonObject.put("cid", cid);
        }
        return jsonObject;
    }

    public static long getLastBootTime(Context context) {
        try {
            long lastBootTime = System.currentTimeMillis() - SystemClock.elapsedRealtime();
            return lastBootTime;
        } catch (Exception e) {
            return 0;
        }
    }
}
