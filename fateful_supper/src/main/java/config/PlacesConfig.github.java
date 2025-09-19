//每次更改PlacesConfig.java請將其中隱私內容除去後貼至此處
package config;

public class PlacesConfig {

    // 環境設定
    public static final String API_KEY = ""; //複製到PlacesConfig.github.java時必須清空
    public static final String API_BASE_URL = "https://places.googleapis.com";

    // API 端點
    public static final String REQUEST_API = "/v1/places:searchNearby";
    // public static final String CONFIRM_API = "/v3/payments/{transactionId}/confirm";

    // 回調網址（需要改為您的實際網址）
    // public static final String PROTOCOL = "https";
    // public static final String PROTOCOL = "http";
    // public static final String DOMAIN = "javaland-2a03.ddns.net/javaland";

    // public static final String CONFIRM_URL = PROTOCOL + "://" + DOMAIN + "/checkout?action=success";
    // public static final String CANCEL_URL = PROTOCOL + "://" + DOMAIN + "/checkout?action=cancel";

    // 商店資訊
    // public static final String CURRENCY = "TWD";
    // public static final String MERCHANT_NAME = "購物商城測試";

    // 訂單編號前綴
    // public static final String ORDER_PREFIX = "ORDER";

    // 私有建構子，防止實例化
    private PlacesConfig() {}

    /**
     * 產生唯一訂單編號
     */
    // public static String generateOrderNumber() {
        // return ORDER_PREFIX + System.currentTimeMillis();
    // }

    /**
     * 檢查是否為測試環境
     */
    // public static boolean isTestEnvironment() {
        // return API_BASE_URL.contains("sandbox");
    // }
}
