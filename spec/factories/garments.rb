FactoryBot.define do
  factory :garment do
    user_id { 1 }
    title { "testtitle" }
    body { "testbody" }
    type { 1 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/test.jpeg'), 'test/jpeg')}
    rate { 5 }
    tag_list { "tag_list" }
    created_at { "2020-01-01T00:00:00Z" }
    updated_at { "2020-01-02T00:00:00Z" }
  end
end
