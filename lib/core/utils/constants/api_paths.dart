class API {
  static String endpoint = 'https://api.wemotions.app/';
  static String testnet = '${API.endpoint}testnet/';
  static String mainnet = '${API.endpoint}mainnet/';

  static String video_link =
      'https://cdn-assets.socialverseapp.com/videos/SocialverseMobileAppLanding_1170x2532.mp4';

  static String socket = 'ws://api.socialverseapp.com/websocket?token=';

  //User
  static String user = 'user';
  static String signup = 'user/create';
  static String login = 'user/login';
  static String logout = 'user/logout';
  static String block_list = 'user/block-list';
  static String suggested = 'users/active';
  static String logoutEverywhere = 'user/logout-everywhere';
  static String oauth = 'auth/firebase';
  static String reset = 'auth/credentials/reset/start';
  static String notification = 'user/notification';

  //Profile
  static String profile = 'profile';
  static String updateProfile = 'profile/update';
  static String updateUsername = 'user/username';
  static String block = 'profile/block';
  static String unblock = 'profile/unblock';
  static String follow = 'profile/follow';
  static String unfollow = 'profile/unfollow';
  static String following = 'profile/following';
  static String followers = 'profile/followers';
  static String active = 'users/active';
  static String device_token = 'user/device-token';

  //Feed
  static String feed = 'feed';

  //Posts
  static String posts = 'posts';
  static String all_posts = 'posts/fetch/all';
  static String createPost = 'posts/add';
  static String uploadToken = 'posts/generate-upload-url';
  static String view = 'post/view';
  static String rating = 'post/rating';
  static String inspire = 'inspire';
  static String bookmarks = 'bookmarks';
  static String comments = 'comments';

  //Search
  static String search = 'search';

  //Subverses
  static String categories = 'categories';
  static String subverse = 'subverse';
  static String crateSphere = 'categories/add';
  static String product = 'product';
  static String subscription = 'subscription';

  //Chat
  static String messages = 'chat/message';
  static String join = 'chat/add/member';
  static String members = 'chat/group/members';

  // Keys
  // static String stripe_key = dotenv.env['STRIPE_KEY']!;
  // static String api_key = dotenv.env['API_KEY']!;
  // static String zx_key = dotenv.env['ZxKEY']!;

  // WalletKit
  static String create = 'wallet/create';
  static String balance = 'wallet/balance';
  static String export = 'wallet/export';
  static String address = 'wallet/get_by_address';
  static String tokens = 'tokens';
  static String activity = 'activity';
  static String transfer_token = 'transfer-tokens';
  static String token_list = 'tokens/balances';
  static String swap_quote = 'swap/quote';
  static String swap_token = 'swap/tokens/list';
  static String search_token = 'swap/token/get_by_contract_address';
  static String send_transaction = 'swap/send/transaction';
  static String nft = 'nfts/list';
  static String nft_collect = 'nfts/wallet/collections';

  //Merchant ID
  static String merchant_id = 'merchant.com.socialverse';
}
