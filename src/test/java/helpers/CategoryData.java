package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class CategoryData {
    
    public static int getRandomNumber(){
        Faker faker = new Faker();
        int num = faker.number().randomDigitNotZero();
        return num;
    }

    public static JSONObject getRandomCategoryValues(){
        Faker faker = new Faker();
        int categoryId = faker.number().numberBetween(30, 100000);
        String name = faker.name().firstName();
        JSONObject json = new JSONObject();
        json.put("categoryId", categoryId);
        json.put("name", name);
        return json;
    }
}
