Feature: Categories

    Background: Define URL
        * url profileStudioUrl
        * def CategoryRequestBody = read('classpath:ProfileStudioAngularAPI/json/newCategoryCreate.json')
        * def CategoryData = Java.type('helpers.CategoryData')
        * set CategoryRequestBody.categoryId = CategoryData.getRandomCategoryValues().categoryId
        * set CategoryRequestBody.name = CategoryData.getRandomCategoryValues().name

    Scenario: Category E2E Test Flow

        #Create a Category    
        Given path 'Category'
        And request CategoryRequestBody
        When method Post
        Then status 201
        * def Id = response.categoryId
        * def name = response.name

        # Get the Category by ID

        Given path 'Category',Id
        When method Get
        Then status 200
        And match response.categoryId == Id
        And match response.name == name

        #Update the Category Details

        Given path 'Category',Id
        And request 

        """
        {
            "categoryId": #(Id),
            "name": #(CategoryRequestBody.name),
            "locked": false
        }

        """
        When method Put
        Then status 204

        # Get the Category by ID after update to check

        Given path 'Category',Id
        When method Get
        Then status 200
        And match response.name == CategoryRequestBody.name

        # Delete the Category

        Given path 'Category',Id
        When method Delete
        Then status 204

        #Confirm the Deletion of the Category

        Given path 'Category',Id
        When method Get
        Then status 204


    Scenario: Get all Categories
        Given path 'Category'
        When method Get
        Then status 200
        And match each response ==
        """
            {
            "categoryId": "#number",
            "name": "#string",
            "locked": "#boolean"
            }

        """