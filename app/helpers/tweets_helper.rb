module TweetsHelper

  def hash_tags
    HashTag.of(current_user).map{|h| h.to_s}
  end

end