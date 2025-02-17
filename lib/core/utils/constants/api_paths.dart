import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  static const String endpoint = 'https://api.wemotions.app/';
  static const String testnet = '${endpoint}testnet/';
  static const String mainnet = '${endpoint}mainnet/';

  static const String videoLink =
      'https://cdn-assets.socialverseapp.com/videos/SocialverseMobileAppLanding_1170x2532.mp4';

  static const String socket = 'wss://api.socialverseapp.com/websocket?token=';

  /// User Endpoints
  static class UserAPI {
    static const String user = 'user';
    static const String signup = 'user/create';
    static const String login = 'user/login';
    static const String logout = 'user/logout';
    static const String blockList = 'user/block-list';
    static const String suggested = 'users/active';
    static const String logoutEverywhere = 'user/logout-everywhere';
    static const String oauth = 'auth/firebase';
    static const String resetPassword = 'auth/credentials/reset/start';
    static const String notification = 'user/notification';
  }

  /// Profile Endpoints
  static class ProfileAPI {
    static const String profile = 'profile';
    static const String updateProfile = 'profile/update';
    static const String updateUsername = 'user/username';
    static const String block = 'profile/block';
    static const String unblock = 'profile/unblock';
    static const String follow = 'profile/follow';
    static const String unfollow = 'profile/unfollow';
    static const String following = 'profile/following';
    static const String followers = 'profile/followers';
    static const String active = 'users/active';
    static const String deviceToken = 'user/device-token';
  }

  /// Feed Endpoints
  static class FeedAPI {
    static const String feed = 'feed';
  }

  /// Post Endpoints
  static class PostAPI {
    static const String posts = 'posts';
    static const String allPosts = 'posts/fetch/all';
    static const String createPost = 'posts/add';
    static const String uploadToken = 'posts/generate-upload-url';
    static const String view = 'post/view';
    static const String rating = 'post/rating';
    static const String inspire = 'inspire';
    static const String bookmarks = 'bookmarks';
    static const String comments = 'comments';
  }

  /// Search Endpoints
  static class SearchAPI {
    static const String search = 'search';
  }

  /// Subverses Endpoints
  static class SubverseAPI {
    static const String categories = 'categories';
    static const String subverse = 'subverse';
    static const String createSphere = 'categories/add';
    static const String product = 'product';
    static const String subscription = 'subscription';
  }

  /// Chat Endpoints
  static class ChatAPI {
    static const String messages = 'chat/message';
    static const String join = 'chat/add/member';
    static const String members = 'chat/group/members';
  }

  /// Wallet Endpoints
  static class WalletAPI {
    static const String create = 'wallet/create';
    static const String balance = 'wallet/balance';
    static const String export = 'wallet/export';
    static const String address = 'wallet/get_by_address';
    static const String tokens = 'tokens';
    static const String activity = 'activity';
    static const String transferToken = 'transfer-tokens';
    static const String tokenList = 'tokens/balances';
    static const String swapQuote = 'swap/quote';
    static const String swapTokenList = 'swap/tokens/list';
    static const String searchToken = 'swap/token/get_by_contract_address';
    static const String sendTransaction = 'swap/send/transaction';
    static const String nft = 'nfts/list';
    static const String nftCollect = 'nfts/wallet/collections';
  }

  /// Merchant ID
  static const String merchantId = 'merchant.com.socialverse';

  /// API Keys (Ensure `.env` is loaded first)
  static final String stripeKey = dotenv.env['STRIPE_KEY'] ?? '';
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
  static final String zxKey = dotenv.env['ZxKEY'] ?? '';
}
