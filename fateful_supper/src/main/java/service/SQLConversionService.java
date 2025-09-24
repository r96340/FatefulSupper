package service;

import org.json.JSONArray;
import org.json.JSONObject;

public class SQLConversionService {

    JSONObject responseJson;
    JSONArray places;

    String name = "";
    String location = "";
    String address = "";
    String gmap_link = "";
    String open_hours = "";
    Double rating = 5.0;
    String category = "";
    String pricing = "";
    String description = "";
    String gallery = "";
    String top_comments = "";
    String website = "";
    String phone = "";
    String payment = "";
    String takeout = "UNKNOWN";
    int pet = 0;
    int wc = 0;
    String gmap_id = "";

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
                "INSERT INTO shops (shop_name, location, address, gmap_link, open_hours, rating, category, pricing, description, gallery, top_comments, website, phone, payment, takeout, pet, wc, gmap_id)"
                + "VALUES ('%s', '%s', '%s', '%s', '%s', %.1f, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%d', '%d', '%s');<br>",
                name, location, address, gmap_link, open_hours, rating, category, pricing, description, gallery, top_comments, website, phone, payment, takeout, pet, wc, gmap_id
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
        if(rating.isNaN()) rating = 5.0;
        JSONObject primaryTypeDisplayName = place.optJSONObject("primaryTypeDisplayName");
        if(primaryTypeDisplayName != null) category = primaryTypeDisplayName.optString("text");
        JSONObject priceRange = place.optJSONObject("priceRange");
        if(priceRange != null){
            JSONObject startPrice = priceRange.optJSONObject("startPrice");
            String priceFloor = startPrice.optString("units");
            JSONObject endPrice = priceRange.optJSONObject("endPrice");
            String priceCeiling;
            if(endPrice != null){
                priceCeiling = endPrice.optString("units");
            } else priceCeiling = "";
            StringBuilder pricingBuilder = new StringBuilder("{\"floor\":\"");
            pricingBuilder.append(priceFloor).append("\",");
            pricingBuilder.append("\"ceiling\":\"").append(priceCeiling).append("\"}");
            pricing = pricingBuilder.toString();
            
        }
        JSONObject editorialSummary = place.optJSONObject("editorialSummary");
        if(editorialSummary != null){
            description = editorialSummary.optString("text");
        } else description = "";
        JSONArray photos = place.optJSONArray("photos");
        if(photos != null){
            JSONObject topPhoto = photos.getJSONObject(0);
            JSONArray topPhotoAttributions = topPhoto.getJSONArray("authorAttributions");
            JSONObject topPhotoAttributionItem = topPhotoAttributions.getJSONObject(0);
            gallery = topPhotoAttributionItem.optString("photoUri");
        }
        JSONArray reviews = place.optJSONArray("reviews");
        if(reviews != null){
            JSONObject topReview = reviews.getJSONObject(0);
            JSONObject topReviewTextWrap = topReview.getJSONObject("text");
            top_comments = topReviewTextWrap.optString("text");
        }
        website = place.optString("websiteUri");
        phone = place.optString("nationalPhoneNumber");
        JSONObject paymentOptions = place.optJSONObject("paymentOptions");
        if(paymentOptions != null){
            Boolean acceptsCashOnly = paymentOptions.optBoolean("acceptsCashOnly");
            if(acceptsCashOnly) {
                payment = "{\"cash\":1}";
            } else {
                StringBuilder paymentBuilder = new StringBuilder("{\"cash\":1,");
                Boolean creditCards = paymentOptions.optBoolean("acceptsCreditCards");
                if(creditCards) paymentBuilder.append("\"creditCards\":1,");
                Boolean debitCards = paymentOptions.optBoolean("acceptsDebitCards");
                if(debitCards) paymentBuilder.append("\"debitCards\":1,");
                Boolean mobile = paymentOptions.optBoolean("acceptsNfc");
                if(mobile) {
                    paymentBuilder.append("\"mobile\":1");
                } else paymentBuilder.append("\"mobile\":0");
                paymentBuilder.append("}");
                payment = paymentBuilder.toString();
            }
        }
        Boolean canTakeout = place.optBoolean("takeout");
        Boolean canDineIn = place.optBoolean("dineIn");
        if(canTakeout != null && canDineIn != null){
            takeout = canTakeout ? "YES" : "NO";
            takeout = canDineIn ? "YES" : "ONLY";
        }
        Boolean allowDogs = place.optBoolean("allowDogs");
        if(allowDogs) pet = 1;
        Boolean hasRestroom = place.optBoolean("restroom");
        if(hasRestroom) wc = 1;
        gmap_id = place.optString("id");
    }
}
