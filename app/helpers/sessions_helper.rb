module SessionsHelper
  def sign_in_out_link
    current_user ? link_to("Sign Out", signout_url, :class => 'signout-link') : link_to("Sign In with LinkedIn", "/auth/linked_in", :class => "signout-link")
  end
end
