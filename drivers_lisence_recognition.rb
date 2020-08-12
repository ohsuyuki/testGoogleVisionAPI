# [START vision_fulltext_detection]
# image_path = "Path to local image file, eg. './image.png'"

require "google/cloud/vision"
require "thor"
require "pry"

def center(bounding_poly)
  return {x: (bounding_poly[0].x + bounding_poly[1].x) / 2, y: (bounding_poly[0].y + bounding_poly[2].y) / 2}
end

def contains(bounding, coord)
  return (bounding[:top_left][:x] <= coord[:x] && coord[:x] <= bounding[:bottom_right][:x]) && (bounding[:top_left][:y] <= coord[:y] && coord[:y] <= bounding[:bottom_right][:y])
end

document_layout = {
  name: {
    bounding: {
      top_left: {x: 68, y: 16},
      bottom_right: {x: 430, y: 50}
    },
    text: ''
  },
  address: {
    bounding: {
      top_left: {x: 68, y: 80},
      bottom_right: {x: 666, y: 130}
    },
    text: ''
  }
}

# image_path = './resources/sample_license.jpg'
image_path = './resources/sample_license_osu.jpg'

image_annotator = Google::Cloud::Vision.image_annotator

response = image_annotator.document_text_detection image: image_path, image_context: {language_hints: [:ja]}

is_first = true
response.responses.each do |res|
  res.text_annotations.each do |annotation|
    if is_first
      is_first = false
      # puts annotation.description
      next
    end

    c = center(annotation.bounding_poly.vertices)
    document_layout.each do |key, value|
      if contains(value[:bounding], c)
        next if ['|'].include?(annotation.description)
        value[:text] << annotation.description
        break
      end
    end

  end
end

document_layout.each do |key, value|
  puts "#{key}: #{value[:text]}"
end