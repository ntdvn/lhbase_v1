import 'package:lhbase_v1/expansion_package/expansion_package.dart';

class Stories {
  final List<Story> stories;
  int currentStory = 0;

  Stories(this.stories);

  Story getCurrentStory() {
    print('getCurrentStory $currentStory');
    return stories[currentStory];
  }
}
