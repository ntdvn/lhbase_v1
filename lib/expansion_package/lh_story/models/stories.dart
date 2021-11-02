import 'package:lhbase_v1/expansion_package/expansion_package.dart';

class Stories {
  final List<StoryData> stories;

  int get size => stories.length;
  int currentStory = 0;

  Stories(this.stories);

  StoryData getCurrentStory() {
    return stories[currentStory];
  }

  bool canNext() {
    if (currentStory + 1 < size) {
      return true;
    }
    return false;
  }

  reset() {
    currentStory = 0;
    stories.forEach((element) {
      element.toReset();
    });
  }
}
