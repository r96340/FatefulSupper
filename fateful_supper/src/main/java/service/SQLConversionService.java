package service;

import org.json.JSONArray;
import org.json.JSONObject;

public class SQLConversionService {

    JSONObject responseJson;
    JSONArray places;

    String name;
    String location;
    String address;
    String gmap_link;
    String open_hours;
    Double rating;
    String category;
    String pricing;

    public SQLConversionService(String placesResponse) {
        this.responseJson = new JSONObject(placesResponse);
        this.places = responseJson.optJSONArray("places");
    }

    public String insert(){
        StringBuilder sql = new StringBuilder();
        for (int i = 0; i < places.length(); i++) {
            var place = places.getJSONObject(i);
            parse(place);
            sql.append(String.format(
                "INSERT INTO shops (shop_name, location, address, gmap_link, open_hours, rating, category, pricing) VALUES ('%s', '%s', '%s', '%s', '%s', %.1f, '%s', '%s');<br>",
                name, location, address, gmap_link, open_hours, rating, category, pricing
            ));
        }
        return sql.toString();
    }

    private void parse(JSONObject place){
        JSONObject displayName = place.optJSONObject("displayName");
        name = displayName.optString("text");
        JSONObject returnLocation = place.optJSONObject("location");
        if(returnLocation != null){
            location = String.format("%s, %s", returnLocation.optString("latitude"), returnLocation.optString("longitude"));
        }
        address = place.optString("formattedAddress");
        gmap_link = place.optString("googleMapsUri");
        JSONObject openingHours = place.optJSONObject("regularOpeningHours");
        if (openingHours != null) {
            JSONArray weekdayDescriptions = openingHours.optJSONArray("weekdayDescriptions");
            open_hours = weekdayDescriptions.toString(0).replace("\\u2013", "-");
        }
        rating = place.optDouble("rating");
        JSONObject primaryTypeDisplayName = place.optJSONObject("primaryTypeDisplayName");
        if(primaryTypeDisplayName != null){
            category = primaryTypeDisplayName.optString("text");
        }
        JSONObject priceRange = place.optJSONObject("priceRange");
        if(priceRange != null){
            JSONObject startPrice = priceRange.optJSONObject("startPrice");
            String priceFloor = startPrice.optString("units");
            JSONObject endPrice = priceRange.optJSONObject("endPrice");
            String priceCeiling;
            if(endPrice != null){
                priceCeiling = endPrice.optString("units");
            } else {
                priceCeiling = "";
            }
            StringBuilder pricingBuilder = new StringBuilder("{\"floor\":\"");
            pricingBuilder.append(priceFloor).append("\",");
            pricingBuilder.append("\"ceiling\":\"").append(priceCeiling).append("\"}");
            pricing = pricingBuilder.toString();
        }
    }

}
