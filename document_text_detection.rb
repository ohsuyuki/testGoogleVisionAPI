# [START vision_fulltext_detection]
# image_path = "Path to local image file, eg. './image.png'"

require "google/cloud/vision"
require "thor"
require "pry"

image_path = './resources/sample_license.jpg'

# image_annotator = Google::Cloud::Vision::ImageAnnotator
image_annotator = Google::Cloud::Vision.image_annotator

# [START vision_fulltext_detection_migration]
response = image_annotator.document_text_detection image: image_path

text = ""
response.responses.each do |res|
  res.text_annotations.each do |annotation|
    text << annotation.description
  end
end

puts text
# [END vision_fulltext_detection_migration]
# [END vision_fulltext_detection]