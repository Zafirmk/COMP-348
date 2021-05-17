require_relative "Car"
include Car

# Global array to hold car objects
$catalogue = []
# Global array to hold the number of different car_makers
$carMakers = []

# Method to convert unordered listings into car objects and store them in catalogue array
def convertListings2Catalougue(fileName)

    # Open file and split it for every line
    # ie: Split it for every listing
    file = File.open(fileName)
    listings = file.read.split("\n")

    #For each individual listing
    for listing in listings

        #Extract year and remove it from the listing
        year = listing[/(^|,| )\d{4}($|,| )/].gsub("," , "").gsub(" ", "")
        listing = listing.gsub(year, "")

        #Extract features and remove it from the listing
        features = listing[/{.*}/]
        listing = listing.gsub(features, "")

        #Extract trim and remove it from the listing
        trim = listing[/(^|,| )[A-Z]{2}($|,| )/].gsub(",", "").gsub(" ", "")
        listing = listing.gsub(trim, "")

        #Extract drivetrain and remove it from the listing
        drivetrain = listing[/(RWD|FWD|AWD)/i]
        listing = listing.gsub(drivetrain, "")

        #Extract status and remove it from the listing
        status = listing[/(Used|New)/i]
        listing = listing.gsub(status, "")

        #Extract car_maker, remove it from the listing and update carMakers array
        car_maker = listing[/(Honda|Toyota|Mercedes|BMW|Lexus)/i]
        if not $carMakers.include? car_maker
            $carMakers.append(car_maker)
        end
        listing = listing.gsub(car_maker, "")

        #Extract type and remove it from the listing
        type = listing[/(Sedan|coupe|hatchback|station|SUV)/i]
        listing = listing.gsub(type, "")

        #Extract transmission and remove it from the listing
        transmission = listing[/(Auto|manual|steptronic)/i]
        listing = listing.gsub(transmission, "")

        #Extract fuel econ and remove it from the listing
        fuelecon = listing[/\d*(.\d*|)L\/\d*km/].gsub(",", "")
        listing = listing.gsub(fuelecon, "")

        #Extract stock and remove it from the listing
        stock = listing[/(\d+[a-z0-9]+[a-z](?<!km\b))(?:,|$)/i].gsub(",", "")
        listing = listing.gsub(stock, "")

        #Extract km and remove it from the listing
        km = listing[/(^|,| )\d+km($|,| )/].gsub(",", "").gsub(" ", "")
        listing = listing.gsub(km, "")

        #remaining listing only contains the model
        model = listing.gsub(",", "").gsub(" ", "")

        #Depending on the car maker create a new object accordingly
        case car_maker
        when "Honda"
            curr_car = Honda.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
        when "Toyota"
            curr_car = Toyota.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
        when "BMW"
            curr_car = BMW.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
        when "Lexus"
            curr_car = Lexus.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
        when "Mercedes"
            curr_car = Mercedes.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
        end


        #If the catalogue is empty, add the car
        if $catalogue.length == 0
            $catalogue.append(curr_car)
        else
            #Check if the car is already in the catalogue
            toAdd = true
            for obj in $catalogue
                if obj.equals(curr_car)
                    toAdd = false
                end
            end
            #Only add if it isn't in the catalogue
            if toAdd
                $catalogue.append(curr_car)
            end
        end


    end


end

#Method to add individual car listing into the array
def Add2Inventory(newListing, fileName)

    #Open the file and check if the new listing is already there
    #If not then add it
    file = File.open(fileName)
    txt = file.read
    if not txt.include? newListing
        File.open(fileName, 'a') { |f| f.write("\n"+newListing)}
    end

    #Extract year and remove it from the listing
    year = newListing[/(^|,| )\d{4}($|,| )/].gsub("," , "").gsub(" ", "")
    newListing = newListing.gsub(year, "")

    #Extract features and remove it from the listing
    features = newListing[/{.*}/]
    newListing = newListing.gsub(features, "")

    #Extract trim and remove it from the listing
    trim = newListing[/(^|,| )[A-Z]{2}($|,| )/].gsub(",", "").gsub(" ", "")
    newListing = newListing.gsub(trim, "")

    #Extract drivetrain and remove it from the listing
    drivetrain = newListing[/(RWD|FWD|AWD)/i]
    newListing = newListing.gsub(drivetrain, "")

    #Extract status and remove it from the listing
    status = newListing[/(Used|New)/i]
    newListing = newListing.gsub(status, "")

    #Extract car_maker, remove it from the listing and update the carMakers array
    car_maker = newListing[/(Honda|Toyota|Mercedes|BMW|Lexus)/i]
    if not $carMakers.include? car_maker
        $carMakers.append(car_maker)
    end
    newListing = newListing.gsub(car_maker, "")

    #Extract type and remove it from the listing
    type = newListing[/(Sedan|coupe|hatchback|station|SUV)/i]
    newListing = newListing.gsub(type, "")

    #Extract transmission and remove it from the listing
    transmission = newListing[/(Auto|manual|steptronic)/i]
    newListing = newListing.gsub(transmission, "")

    #Extract fuelecon and remove it from the listing
    fuelecon = newListing[/\d*(.\d*|)L\/\d*km/].gsub(",", "")
    newListing = newListing.gsub(fuelecon, "")

    #Extract stock and remove it from the listing
    stock = newListing[/(\d+[a-z0-9]+[a-z](?<!km\b))(?:,|$)/i].gsub(",", "")
    newListing = newListing.gsub(stock, "")

    #Extract km and remove it from the listing
    km = newListing[/(^|,| )\d+km($|,| )/].gsub(",", "").gsub(" ", "")
    newListing = newListing.gsub(km, "")

    #Remaining listing is just the model
    model = newListing.gsub(",", "").gsub(" ", "")

    #Depending on the car_maker create a new car object
    case car_maker
    when "Honda"
        curr_car = Honda.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
    when "Toyota"
        curr_car = Toyota.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
    when "BMW"
        curr_car = BMW.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
    when "Lexus"
        curr_car = Lexus.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
    when "Mercedes"
        curr_car = Mercedes.new(km, type, stock, drivetrain, status, fuelecon, model, year, trim, car_maker, transmission, features)
    end

    #If empty add the car object to the catalogue
    if $catalogue.length == 0
        $catalogue.append(curr_car)
    else
        #Check if the car is already in the catalogue
        toAdd = true
        for obj in $catalogue
            if obj.equals(curr_car)
                toAdd = false
            end
        end
        #Only add if it isn't in the catalogue
        if toAdd
            $catalogue.append(curr_car)
        end
    end

end

#Method to save the organized contents into a file
def saveCatalogue2File(newFile)
    file = File.open(newFile, "w")
    for x in $carMakers.sort
        toWrite = searchInventory({"car_maker" => x})
        file.write(toWrite)
    end
    file.close()
end

#Method to search the catalogue array using a hash
def searchInventory(hash)

    #Value to return
    toReturn = ""

    #Key
    feature = nil
    #Value
    feature_value = nil

    # Split key - value and assign
    hash.each do |key, value|
        feature = key.downcase
        feature_value = value.downcase
    end

    if feature.casecmp?("features")
        list_of_features = feature_value.gsub("}", "").gsub("{", "").downcase.split(", ")
        for car in $catalogue
            curr_car_features = car.getVal("features").gsub("}", "").gsub("{", "").downcase.split(", ")
            featuresEqual = true
            for i in list_of_features
                if not curr_car_features.include?(i)
                    featuresEqual = false
                end
            end
            if featuresEqual
                toReturn = toReturn + car.to_s + "\n"
            end
        end
        return(toReturn)

    else
        for car in $catalogue
            if car.getVal(feature).casecmp?(feature_value)
                toReturn = toReturn + car.to_s + "\n"
            end
        end
        return(toReturn)
    end

end

convertListings2Catalougue("listings.txt")
saveCatalogue2File("sortedListings.txt")
puts searchInventory({"model" => "camry"})