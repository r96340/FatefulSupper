<html>
<body>
    <h1 id="title">Fateful Supper LOADING...</h1>
    <form id="searchForm" action="search" method="get" style="display: none;">
        <label for="includedTypes">Included Types (comma-separated):</label>
        <input type="text" id="includedTypes" name="includedTypes" required value="restaurant"><br><br>
        <label for="maxResultCount">Max Result Count:</label>
        <input type="number" id="maxResultCount" name="maxResultCount" required value="10"><br><br>
        <label for="centerLatitude">Center Latitude:</label>
        <input type="text" id="centerLatitude" name="centerLatitude" required value="25.0216448"><br><br>
        <label for="centerLongitude">Center Longitude:</label>
        <input type="text" id="centerLongitude" name="centerLongitude" required value="121.540202"><br><br>
        <label for="radius">Radius:</label>
        <input type="text" id="radius" name="radius" required value="1000.0"><br><br>
        <label for="key">API Key:</label>
        <input type="text" id="key" name="key" required><br><br>
        <input type="submit" value="Search Nearby Restaurants">
    </form>
    <script>
        navigator.geolocation.getCurrentPosition(
            function(position) {
                console.log(position.coords.latitude);
                console.log(position.coords.longitude);
                document.getElementById('centerLatitude').value = position.coords.latitude;
                document.getElementById('centerLongitude').value = position.coords.longitude;
                document.getElementById('title').innerText = 'Fateful Supper';
                document.getElementById('searchForm').style.display = 'block';
            },
            function(error) {
                console.error('Geolocation error:', error);
                document.getElementById('title').innerText = 'Fateful Supper LOADING FAILED Please check location or internet availability and reload...';
            }
        );
    </script>
</body>
</html>
