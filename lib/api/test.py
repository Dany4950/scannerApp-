import requests

def test_flask_app():
    base_url = "http://127.0.0.1:5000"

    # Test /location endpoint
    location_image_path = "static/images/location/Location-1.png"
    with open(location_image_path, "rb") as image:
        files = {"barcodeImage": image}
        response = requests.post(f"{base_url}/location", files=files)
        location_result = response.json()
        print("Location endpoint response:", location_result)
    
    if response.status_code != 200:
        print("Failed to test /location endpoint")
        return

    # Test /items endpoint
    item_image_path = "static/images/products/Product-3.png"
    with open(item_image_path, "rb") as image:
        files = {"itemBarcodeImage": image}
        headers = {
            "locationData": location_result["data"],
            "hashKey": location_result["usageHash"]
        }
        data = {"quantity": "10"}
        
        # Debug prints to check headers and data
        print("Headers being sent:", headers)
        response = requests.post(f"{base_url}/items", files=files, headers=headers, data=data)
        items_result = response.json()
        print("Items endpoint response:", items_result)

    if response.status_code != 201:
        print("Failed to test /items endpoint")
        return

    response = requests.post(f"{base_url}/file", headers=headers)

    if response.status_code == 200:
        print("File endpoint response: File download initiated")
        # Optionally save the file to check if the CSV is correct
        with open("downloaded_file.csv", "wb") as f:
            f.write(response.content)
        print("File downloaded successfully as downloaded_file.csv")
    else:
        print("Failed to test /file endpoint")

    # Test /locationData endpoint
    location_data = {
        "locationData": "TestLocation123"
    }
    response = requests.post(f"{base_url}/locationData", json=location_data)
    location_data_result = response.json()
    print("LocationData endpoint response:", location_data_result)

    if response.status_code != 200:
        print("Failed to test /locationData endpoint")
        return

    # Test /itemsData endpoint
    items_data = {
        "itemBarcodeData": "TestItemBarcode123",
        "quantity": 5
    }
    headers = {
        "LocationData": location_data_result["data"],
        "HashKey": location_data_result["usageHash"]
    }
    response = requests.post(f"{base_url}/itemsData", json=items_data, headers=headers)
    items_data_result = response.json()
    print("ItemsData endpoint response:", items_data_result)

    if response.status_code != 201:
        print("Failed to test /itemsData endpoint")
        return

    # Test /query endpoint
    query_data = {
        "locationData": "Location-1"
    }
    response = requests.post(f"{base_url}/query", json=query_data)
    query_result = response.json()
    print("Query endpoint response:", query_result)

    if response.status_code != 200:
        print("Failed to test /query endpoint")
        return

    print("All tests passed successfully!")

if __name__ == "__main__":
    test_flask_app()