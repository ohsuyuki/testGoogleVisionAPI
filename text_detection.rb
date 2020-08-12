image_path = './resources/sample_license.jpg'

require "google/cloud/vision"

image_annotator = Google::Cloud::Vision.image_annotator

response = image_annotator.text_detection(
  image:       image_path,
  max_results: 1 # optional, defaults to 10
)

response.responses.each do |res|
  res.text_annotations.each do |text|
    puts text.description
  end
end
# unchi
