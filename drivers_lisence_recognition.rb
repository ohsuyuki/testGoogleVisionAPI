# [START vision_fulltext_detection]
# image_path = "Path to local image file, eg. './image.png'"

require "google/cloud/vision"
require "thor"
require "pry"

def center(bounding_poly)
  return {x: (bouding_poly[0].x + bouding_poly[1].x) / 2, y: (bouding_poly[0].y + bouding_poly[2].y) / 2}
end

def contains(bounding, coord)
  # bounding[:top_left][:x] <= coord.x && bounding[:bottom_right][:y] 
end

document_layout = {
  name: {
    bounding: {
      top_left: {x: 0, y: 0},
      bottom_right: {x: 0, y: 0}
    },
    text: ''
  },
  address: {
    bounding: {
      top_left: {x: 0, y: 0},
      bottom_right: {x: 0, y: 0}
    },
    text: ''
  }
}

image_path = './resources/sample_license.jpg'

# image_annotator = Google::Cloud::Vision::ImageAnnotator
image_annotator = Google::Cloud::Vision.image_annotator

# [START vision_fulltext_detection_migration]
response = image_annotator.document_text_detection image: image_path

# text = ""
is_first = true
response.responses.each do |res|
  res.text_annotations.each do |annotation|
    if is_first
      is_first = false
      next
    end

    # text << annotation.description
    c = center(annotation.bounding_poly)
    document_layout.each do |key, value|
      if contains(value[:bounding], c)
        value[:text] << annotation.description
        break
      end
    end

  end
end

# puts text

document_layout.each do |key, value|
  puts "#{key}: #{value[:text]}"
end

# [END vision_fulltext_detection_migration]
# [END vision_fulltext_detection]