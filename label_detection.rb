# Imports the Google Cloud client library
require "google/cloud/vision"

# Instantiates a client
image_annotator = Google::Cloud::Vision.image_annotator

# The name of the image file to annotate
file_name = "./resources/cat.jpg"

# Performs label detection on the image file
response = image_annotator.label_detection image: file_name
response.responses.each do |res|
  puts "Labels:"
  res.label_annotations.each do |label|
    puts label.description
  end
end