require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  test "can' get posts with no auth" do
    get "/api/v1/posts"
    assert_response :forbidden
  end
  test "can get posts with header" do
    get "/api/v1/posts", headers: { "HTTP_AUTHORIZATION" => "Bearer " + build_jwt }
    assert_response :success
  end
  test "expired jwt fails" do
    get "/api/v1/posts", headers: { "HTTP_AUTHORIZATION" => "Bearer " + build_jwt(-1) }
    assert_response :forbidden
  end

  def build_jwt(valid_for_minutes = 5)
    exp = Time.now.to_i + (valid_for_minutes*60)
    payload = { "iss": "fusionauth.io",
                "exp": exp,
                "aud": "238d4793-70de-4183-9707-48ed8ecd19d9",
                "sub": "19016b73-3ffa-4b26-80d8-aa9287738677",
                "name": "Dan Moore",
                "roles": ["USER"]
    }

    JWT.encode payload, Rails.configuration.x.oauth.jwt_secret, 'HS256'

  end
end
