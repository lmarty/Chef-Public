require File.expand_path('../support/helpers', __FILE__)

describe_recipe "rabbitmq_settings::from_databag" do
  include Helpers::RabbitMQ

  describe "vhosts" do
    it 'vhost was created.' do
      vhost_name = "/one"
      get_vhosts(vhost_name).must_match(/^#{vhost_name}$/)
    end

    it 'vhost was not created.' do
      vhost_name = "/two"
      get_vhosts(vhost_name).wont_match(/^#{vhost_name}$/)
    end

    it 'vhost was deleted.' do
      vhost_name = "/three"
      get_vhosts(vhost_name).wont_match(/^#{vhost_name}$/)
    end
  end

  describe "users" do
    it 'user was created.' do
      user_name = "user_one"
      get_users(user_name).must_match(/^#{user_name}\t/)
    end

    it 'user was not created.' do
      user_name = "user_two"
      get_users(user_name).wont_match(/^#{user_name}\t/)
    end

    it 'user was deleted.' do
      user_name = "user_four"
      get_users(user_name).wont_match(/^#{user_name}\t/)
    end
  end

  describe "permissions" do
    it 'user has parmission for vdir.' do
      user_name = "user_one"
      get_permissions_by_vhost("/one").must_match(/^#{user_name}\t/)
    end

    it 'user does not has parmission for vdir.' do
      user_name = "user_two"
      get_permissions_by_vhost("/one").wont_match(/^#{user_name}\t/)
    end

    it 'removed parmission to user for vdir.' do
      user_name = "user_three"
      get_permissions_by_vhost("/one").wont_match(/^#{user_name}\t/)
    end
  end

end
