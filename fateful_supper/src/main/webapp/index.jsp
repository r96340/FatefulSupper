<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        let selected = false;
    </script>
    <title>宵夜命運網API測試頁面</title>
</head>
<body>
    <h1 id="title">宵夜命運網API載入中...</h1>
    <form id="searchForm" action="search" method="get" style="display: none;">
        <label for="includedTypes">搜尋類型:</label>
        <%-- 之後改為下拉式選單 --%>
        <select id="includedTypes" name="includedTypes" required>
            <option value="restaurant" selected>餐廳</option>
            <option value="food_store">食物</option>
            <option value="food_delivery">食物外送（food_delivery）</option>
            <option value="convenience_store">超商</option>
            <option value="american_restaurant">美式料理（american_restaurant）</option>
            <option value="asian_restaurant">亞洲料理</option>
            <option value="bar_and_grill">串燒</option>
            <option value="barbecue_restaurant">燒烤</option>
            <option value="breakfast_restaurant">早餐店（包含燒餅油條、清粥小菜）</option>
            <option value="chinese_restaurant">中式料理（包含台式料理）</option>
            <option value="deli">熟食</option>
            <option value="diner">餐館</option>
            <option value="fast_food_restaurant">速食</option>
            <option value="hamburger_restaurant">漢堡</option>
            <option value="italian_restaurant">義式料理</option>
            <option value="japanese_restaurant">日式料理</option>
            <option value="meal_delivery">食物外送（meal_delivery）</option>
            <option value="meal_takeaway">食物外帶</option>
            <option value="pizza_restaurant">披薩</option>
            <option value="ramen_restaurant">拉麵</option>
            <option value="seafood_restaurant">海鮮</option>
            <option value="vegan_restaurant">素食（vegan_restaurant）</option>
            <option value="vegetarian_restaurant">素食（vegetarian_restaurant）</option>
        </select><br><br>
        <div>
            <label for="excludedTypes">排除類型:</label><br>
            <%-- 博物館選項為無排除類型時補空用 --%>
            <input type="checkbox" id="excludedTypes" name="excludedTypes" value="museum" checked hidden>
            <input type="checkbox" id="excludeRestaurant" name="excludedTypes" value="restaurant">
            <label for="excludeRestaurant">餐廳</label>
            <input type="checkbox" id="excludeFoodStore" name="excludedTypes" value="food_store">
            <label for="excludeFoodStore">食物</label>
            <input type="checkbox" id="excludeFoodDelivery" name="excludedTypes" value="food_delivery">
            <label for="excludeFoodDelivery">食物外送（food_delivery）</label>
            <input type="checkbox" id="excludeConvenienceStore" name="excludedTypes" value="convenience_store">
            <label for="excludeConvenienceStore">超商</label>
            <input type="checkbox" id="excludeAmericanRestaurant" name="excludedTypes" value="american_restaurant">
            <label for="excludeAmericanRestaurant">美式料理</label><br>
            <input type="checkbox" id="excludeAsianRestaurant" name="excludedTypes" value="asian_restaurant">
            <label for="excludeAsianRestaurant">亞洲料理</label>
            <input type="checkbox" id="excludeBarAndGrill" name="excludedTypes" value="bar_and_grill">
            <label for="excludeBarAndGrill">串燒</label>
            <input type="checkbox" id="excludeBarbecueRestaurant" name="excludedTypes" value="barbecue_restaurant">
            <label for="excludeBarbecueRestaurant">燒烤</label>
            <input type="checkbox" id="excludeBreakfastRestaurant" name="excludedTypes" value="breakfast_restaurant">
            <label for="excludeBreakfastRestaurant">早餐店（包含燒餅油條、清粥小菜）</label><br>
            <input type="checkbox" id="excludeChineseRestaurant" name="excludedTypes" value="chinese_restaurant">
            <label for="excludeChineseRestaurant">中式料理（包含台式料理）</label>
            <input type="checkbox" id="excludeDeli" name="excludedTypes" value="deli">
            <label for="excludeDeli">熟食</label>
            <input type="checkbox" id="excludeDiner" name="excludedTypes" value="diner">
            <label for="excludeDiner">餐館</label>
            <input type="checkbox" id="excludeFastFoodRestaurant" name="excludedTypes" value="fast_food_restaurant">
            <label for="excludeFastFoodRestaurant">速食</label>
            <input type="checkbox" id="excludeHamburgerRestaurant" name="excludedTypes" value="hamburger_restaurant">
            <label for="excludeHamburgerRestaurant">漢堡</label>
            <input type="checkbox" id="excludeItalianRestaurant" name="excludedTypes" value="italian_restaurant">
            <label for="excludeItalianRestaurant">義式料理</label><br>
            <input type="checkbox" id="excludeJapaneseRestaurant" name="excludedTypes" value="japanese_restaurant">
            <label for="excludeJapaneseRestaurant">日式料理</label>
            <input type="checkbox" id="excludeMealDelivery" name="excludedTypes" value="meal_delivery">
            <label for="excludeMealDelivery">食物外送（meal_delivery）</label>
            <input type="checkbox" id="excludeMealTakeaway" name="excludedTypes" value="meal_takeaway">
            <label for="excludeMealTakeaway">食物外帶</label>
            <input type="checkbox" id="excludePizzaRestaurant" name="excludedTypes" value="pizza_restaurant">
            <label for="excludePizzaRestaurant">披薩</label>
            <input type="checkbox" id="excludeRamenRestaurant" name="excludedTypes" value="ramen_restaurant">
            <label for="excludeRamenRestaurant">拉麵</label><br>
            <input type="checkbox" id="excludeSeafoodRestaurant" name="excludedTypes" value="seafood_restaurant">
            <label for="excludeSeafoodRestaurant">海鮮</label>
            <input type="checkbox" id="excludeVeganRestaurant" name="excludedTypes" value="vegan_restaurant">
            <label for="excludeVeganRestaurant">素食（vegan_restaurant）</label>
            <input type="checkbox" id="excludeVegetarianRestaurant" name="excludedTypes" value="vegetarian_restaurant">
            <label for="excludeVegetarianRestaurant">素食（vegetarian_restaurant）</label>
        </div><br><br>
        <label for="maxResultCount">最大結果數(1-20):</label>
        <input type="number" id="maxResultCount" name="maxResultCount" required value="10"><br><br>
        <label for="centerLatitude">中心緯度:</label>
        <input type="text" id="centerLatitude" name="centerLatitude" required value="25.0216448"><br><br>
        <label for="centerLongitude">中心經度:</label>
        <input type="text" id="centerLongitude" name="centerLongitude" required value="121.540202"><br><br>
        <label for="radius">搜尋半徑:</label>
        <input type="text" id="radius" name="radius" required value="1000.0"><br><br>
        <label for="rankPreference">排序偏好:</label>
        <select id="rankPreference" name="rankPreference" required>
            <option value="POPULARITY" selected>知名度優先</option>
            <option value="DISTANCE">距離優先</option>
        </select><br><br>
        <div>
            <input type="checkbox" id="select_all" onclick="setSelectStates();">
            <label for="select_all">回傳資料:</label><br>
            <input type="checkbox" id="returnOpenNow" name="additionalReturns" value="places.regularOpeningHours.openNow">
            <label for="returnOpenNow">現在營業中與否</label>
            <input type="checkbox" id="returnTypes" name="additionalReturns" value="places.types">
            <label for="returnTypes">所有類型</label>
            <input type="checkbox" id="returnNationalPhoneNumber" name="additionalReturns" value="places.nationalPhoneNumber">
            <label for="returnNationalPhoneNumber">商家電話</label>
            <input type="checkbox" id="returnPrimaryTypeDisplayName" name="additionalReturns" value="places.primaryTypeDisplayName">
            <label for="returnPrimaryTypeDisplayName">第一類型（的當地名稱）</label><br>
            <input type="checkbox" id="returnFormattedAddress" name="additionalReturns" value="places.formattedAddress">
            <label for="returnFormattedAddress">完整地址</label>
            <input type="checkbox" id="returnShortFormattedAddress" name="additionalReturns" value="places.shortFormattedAddress">
            <label for="returnShortFormattedAddress">簡略地址</label>
            <input type="checkbox" id="returnAddressComponents" name="additionalReturns" value="places.addressComponents">
            <label for="returnAddressComponents">詳細分級地址</label>
            <input type="checkbox" id="returnLocation" name="additionalReturns" value="places.location">
            <label for="returnLocation">經緯度</label>
            <input type="checkbox" id="returnRating" name="additionalReturns" value="places.rating">
            <label for="returnRating">評分</label><br>
            <input type="checkbox" id="returnGoogleMapsUri" name="additionalReturns" value="places.googleMapsUri">
            <label for="returnGoogleMapsUri">Google Maps連結</label>
            <input type="checkbox" id="returnWebsiteUri" name="additionalReturns" value="places.websiteUri">
            <label for="returnWebsiteUri">商家網站連結</label>
            <input type="checkbox" id="returnReviews" name="additionalReturns" value="places.reviews">
            <label for="returnReviews">留言</label>
            <input type="checkbox" id="returnRegularOpeningHours" name="additionalReturns" value="places.regularOpeningHours">
            <label for="returnRegularOpeningHours">營業時間</label>
            <input type="checkbox" id="returnPhotos" name="additionalReturns" value="places.photos">
            <label for="returnPhotos">圖片</label><br>
            <input type="checkbox" id="returnBusinessStatus" name="additionalReturns" value="places.businessStatus">
            <label for="returnBusinessStatus">營業狀況</label>
            <input type="checkbox" id="returnEditorialSummary" name="additionalReturns" value="places.editorialSummary">
            <label for="returnEditorialSummary">Google Maps貢獻者整理的商家簡介</label>
            <input type="checkbox" id="returnPaymentOptions" name="additionalReturns" value="places.paymentOptions">
            <label for="returnPaymentOptions">付款方式</label>
            <input type="checkbox" id="returnPriceRange" name="additionalReturns" value="places.priceRange">
            <label for="returnPriceRange">價格範圍</label><br>
            <input type="checkbox" id="returnUserRatingCount" name="additionalReturns" value="places.userRatingCount">
            <label for="returnUserRatingCount">留言的數量</label>
            <input type="checkbox" id="returnTakeout" name="additionalReturns" value="places.takeout,places.dineIn">
            <label for="returnTakeout">是否可以外帶/內用</label>
            <input type="checkbox" id="returnDelivery" name="additionalReturns" value="places.delivery">
            <label for="returnDelivery">是否可以外送</label>
            <input type="checkbox" id="returnServesBeer" name="additionalReturns" value="places.servesBeer">
            <label for="returnServesBeer">是否提供啤酒</label><br>
            <input type="checkbox" id="returnServesVegetarian" name="additionalReturns" value="places.servesVegetarianFood">
            <label for="returnServesVegetarian">是否提供素食</label>
            <input type="checkbox" id="returnAllowsDogs" name="additionalReturns" value="places.allowsDogs">
            <label for="returnAllowsDogs">是否允許犬隻進入</label>
            <input type="checkbox" id="returnRestroom" name="additionalReturns" value="places.restroom">
            <label for="returnRestroom">是否有廁所</label>
            <input type="checkbox" id="returnAccessibilityOptions" name="additionalReturns" value="places.accessibilityOptions">
            <label for="returnAccessibilityOptions">無障礙設施</label>
        </div><br><br>
        <label for="key">API金鑰:</label>
        <input type="text" id="key" name="key" required><br><br>
        <label>搜尋</label><br>
        <input type="submit" value="搜尋" onclick="form.action='search';">
        <input type="submit" value="產生搜尋URL" onclick="form.action='to_url';"><br>
        <input type="submit" value="產生SQL" onclick="form.action='to_sql';">
        <input type="submit" value="產生語法URL" onclick="form.action='to_sql_url';">
    </form>
    <script>
        navigator.geolocation.getCurrentPosition(
            function(position) {
                console.log(position.coords.latitude);
                console.log(position.coords.longitude);
                document.getElementById('centerLatitude').value = position.coords.latitude;
                document.getElementById('centerLongitude').value = position.coords.longitude;
                document.getElementById('title').innerText = '宵夜命運網API測試頁面';
                document.getElementById('searchForm').style.display = 'block';
            },
            function(error) {
                console.error('Geolocation error:', error);
                document.getElementById('title').innerText = '宵夜命運網API載入失敗，請檢查位置或網路連線後重新載入...';
            }
        );

        function setSelectStates() {
            if(selected){
                let selectAllCheckbox = document.getElementById('select_all');
                let checkboxes = document.querySelectorAll('input[name="additionalReturns"]');
                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = false;
                });
                selected = false;
            } else{
                let selectAllCheckbox = document.getElementById('select_all');
                let checkboxes = document.querySelectorAll('input[name="additionalReturns"]');
                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = selectAllCheckbox.checked;
                });
                selected = true;
            }
        }
    </script>
</body>
</html>
