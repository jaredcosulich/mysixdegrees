# Load the rails application
DEFAULT_PAPERCLIP_OPTIONS = {}

DEVISE_MAILER_FROM       = "support@mysixdegrees.me"
LIVE_PERSONS_EMAIL       = 'help@mysixdegrees.me'

FACEBOOK_APP_ID          = "213491825331116"
FACEBOOK_APP_SECRET      = "3bc4798fec78dc85235d543aa96e5f98"
FACEBOOK_APP_PERMISSIONS = "email,offline_access,publish_stream"

DEFAULT_FB_SHARE_IMAGE   = "http://mysixdegrees.me/images/missing.png"
DEFAULT_FB_POST_NAME     = "mysixdegrees.me"

DEFAULT_PAGE_TITLE       = "mysixdegrees.me"
DEFAULT_PAGE_DESCRIPTION = "What words best describe you?"

TWITTER_SECRET_KEY       = "L0LJGa5g4TWNUJfK9jmACNt3i2P2ykUw0TVbysQinIg"
TWITTER_CONSUMER_KEY     = "D4sOenvRrSaI1GIGTTEeSQ"

DEFAULT_SHARE_URL        = "http://mysixdegrees.me"


require File.expand_path('../application', __FILE__)

# Initialize the rails application
OmniauthDeviseExample::Application.initialize!
