import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/home/model/home_model.dart';
import 'package:tdd/home/service/home_service.dart';
import 'package:vexana/vexana.dart';
class MockIHomeService extends Mock implements IHomeService{
  late final INetworkManager networkManager;
  MockIHomeService(this.networkManager):super();
  @override
  Future<List<ReqProfile>?> getAllItems() async {
    final response = await networkManager.send<ReqProfile, List<ReqProfile>>('/users',
        parseModel: ReqProfile(), method: RequestType.GET);

    return response.data;
  }
}
void main() {
  late INetworkManager networkManager;
  late MockIHomeService mockIHomeService;
  late IHomeService homeService;
  setUp(() {
    networkManager =
        NetworkManager(isEnableLogger: true, options: BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"));

    homeService = HomeService(networkManager);
    mockIHomeService = MockIHomeService(networkManager);
  });
  test('Get All List Data', () async {
    final listDatas = await networkManager.send<ReqProfile, List<ReqProfile>>('/users',
        parseModel: ReqProfile(), method: RequestType.GET);

    expect(listDatas.data, isNotNull);
  });

  test('Get All List Manager', () async {
    final listDatas = await homeService.getAllItems();

    expect(listDatas, isNotNull);
  });

  test('Get Empty List Manager Mock', () async {
    when(mockIHomeService.getAllItems().then((value)async => []));
  expect(await mockIHomeService.getAllItems(), isNotEmpty);
  });
  test('Get Custom List Manager Mock', () async {
    final microprofile=ReqProfile(id:1,name: "Kadir Pınar",username: "kadir",email: "kadir");
    when(mockIHomeService.getAllItems().then((value)async =>microprofile));
    expect((await mockIHomeService.getAllItems())![0].id, microprofile.id);
  });
}
