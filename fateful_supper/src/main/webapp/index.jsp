<html>
<body>
    <h1>Fateful Supper</h1>
    <form action="search" method="get">
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
        <input type="submit" value="Search Nearby Restaurants">
    </form>
</body>
</html>
