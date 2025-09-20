<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
    <h1 id="title">宵夜命運網載入中...</h1>
    <form id="searchForm" action="search" method="get" style="display: none;">
        <label for="includedTypes">搜尋類型:</label>
        <%-- 之後改為下拉式選單 --%>
        <input type="text" id="includedTypes" name="includedTypes" required value="restaurant"><br><br>
        <label for="maxResultCount">最大結果數(1-20):</label>
        <input type="number" id="maxResultCount" name="maxResultCount" required value="10"><br><br>
        <label for="centerLatitude">中心緯度:</label>
        <input type="text" id="centerLatitude" name="centerLatitude" required value="25.0216448"><br><br>
        <label for="centerLongitude">中心經度:</label>
        <input type="text" id="centerLongitude" name="centerLongitude" required value="121.540202"><br><br>
        <label for="radius">搜尋半徑:</label>
        <input type="text" id="radius" name="radius" required value="1000.0"><br><br>
        <label for="key">API金鑰:</label>
        <input type="text" id="key" name="key" required><br><br>
        <input type="submit" value="搜尋">
    </form>
    <script>
        navigator.geolocation.getCurrentPosition(
            function(position) {
                console.log(position.coords.latitude);
                console.log(position.coords.longitude);
                document.getElementById('centerLatitude').value = position.coords.latitude;
                document.getElementById('centerLongitude').value = position.coords.longitude;
                document.getElementById('title').innerText = '宵夜命運網';
                document.getElementById('searchForm').style.display = 'block';
            },
            function(error) {
                console.error('Geolocation error:', error);
                document.getElementById('title').innerText = '宵夜命運網載入失敗，請檢查位置或網路連線後重新載入...';
            }
        );
    </script>
</body>
</html>
