require 'test_helper'

class FixturesTest < ActiveSupport::TestCase
  test 'loading fixtures using ShopifyAPI::Mock::Fixtures' do
    path = File.expand_path('../fixtures', __FILE__)
    fixtures = ShopifyAPI::Mock::Fixtures.new(path)
    assert fixtures[:get]['/orders/1.json'].is_a?(ShopifyAPI::Mock::Fixture)
    assert fixtures[:get]['/orders/2.json'].is_a?(ShopifyAPI::Mock::Fixture)
    assert fixtures[:delete]['/orders/3.json'].is_a?(ShopifyAPI::Mock::Fixture)
    assert fixtures[:delete]['/orders/4.json'].is_a?(ShopifyAPI::Mock::Fixture)
  end

  test 'ShopifyAPI::Mock::Fixtures is enumerable' do
    path = File.expand_path('../fixtures', __FILE__)
    fixtures = ShopifyAPI::Mock::Fixtures.new(path)
    assert_equal 4, fixtures.count
    assert fixtures.all? do |verb, endpoint, fixture|
      assert verb.is_a?(Symbol)
      assert endpoint.is_a?(String)
      assert fixture.is_a?(ShopifyAPI::Mock::Fixture)
    end
  end
end
