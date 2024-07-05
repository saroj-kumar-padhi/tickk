import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
          "https://tickkbucket.s3.eu-north-1.amazonaws.com/PYRImages/1720082592191_123456789.jpg?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEOX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCmV1LW5vcnRoLTEiRzBFAiEA5mRF%2BUAPfFo8MsLwY%2FX9wXCgZOCKPsPHb5r6g8z6jXACIDBquL4FFDTWbyQKh2PHdSHjnumLw0SD3kt5Oezj05KuKu0CCJ7%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMNjU0NjU0NDc2NTgzIgwR1wh2BGSsBcxnkikqwQJG2qE1eWscK2VPf7%2BkWVfjgsqORQg0uN6t7xnpeCxg98hCfD%2BHwlfUeJS3%2BmO%2BPfUV4T5J9vzQj4IxlaDQi8GQ8sTwSwSYAewihx0Vxb%2BCcFQ1i96ovu7D7KjVyoPPvHHr4MiiticTRW2PYCDeWwoAL5FB0AKAMFrJjCOiv3RRvXQPH3HF7wL3JYGaeIhiuRC0BGoHEHytI9l3hGHAlvxIcp8ZtGTw%2FnG2jbIOuRXvYdbsvBaWv9L6koWGKFtODe%2FniYVYtIyUHBloYtGbRqvJH9O8mzFT%2BZM8vA7n%2B2mJZNCypHubvPm84HWDMv%2Bl4QQgrZJ1%2BF6YDtrz1Mg%2FtI%2FpaUEdBaSyXyYVO6POkGraDpw4Ad%2BfnXA7JWSTkHdTv3lfgy1LKVZAC5bJ0zM07sawx7pCTfbhcSbc3s8uTsZihPIwlN6YtAY6swIKJ6kmTSlG%2BF%2FGiVpdiR%2FpggB25LQU8K1t87JS4UlSS3plL6CjCRPS%2F9kVr%2BJCAIIRtAZxz9pqYX3KdNr2xIPESkvJWXcrzSkeeTR%2B7yHvnAywlGUXwAUwOIKCpSvLS03jqTzoSzLHcWQy7%2FsNzxtWYzV%2FQ44Xie%2BAc6sjpgN1uQu8A7%2FupC9A4LyKYHSwZVToq1Bqp4w9eUGN41VbPn%2Bveodoy3e5cY7Cd1b0%2B4tirubzutshGjQOVCozKJm02HJ7nBRLziujuEzUVl6lKLXPo%2BCZTiEYhtZ77oC3tbNPBqBrl4FmUDqRKyBbRyKzWmwzCRTzhTcDtJa2kgOCNfNguSra4XbT8LFGFgyQsdCgyLwuQVNoFXPasTDiO0AJ9xBwQIbgvGzUM55UjGqkAMEkmZqW&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240704T084345Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAZQ3DSSET5VLYHBGZ%2F20240704%2Feu-north-1%2Fs3%2Faws4_request&X-Amz-Signature=98beb0b31af8ace88f3dc88a3cebed42e302695abcb0b473d7aa1789d55c5295"),
    );
  }
}
