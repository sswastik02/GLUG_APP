import 'package:glug_app/models/blog_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlogPostsBloc {
  final _repository = Repository();
  final _blogPostsFetcher = BehaviorSubject<BlogResponse>();

  Stream<BlogResponse> get allBlogPosts => _blogPostsFetcher.stream;

  fetchAllBlogPosts() async {
    BlogResponse blogPost = await _repository.fetchAllBlogPosts();
    if (!_blogPostsFetcher.isClosed) _blogPostsFetcher.sink.add(blogPost);
  }

  dispose() {
    _blogPostsFetcher.close();
  }
}

final blogPostsBloc = BlogPostsBloc();
