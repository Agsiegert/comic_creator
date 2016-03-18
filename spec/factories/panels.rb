FactoryGirl.define do
  factory :panel do
    caption {FFaker::HipsterIpsum.phrase}
    image Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/image_1.png", "image/png")
  end
end
