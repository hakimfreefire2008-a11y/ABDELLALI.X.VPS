import '../models/config_model.dart';

class ConfigService {

  final List<ConfigModel> configs = [];

  void addConfig(ConfigModel config) {
    configs.add(config);
  }

  void removeConfig(int index) {
    configs.removeAt(index);
  }

  List<ConfigModel> getConfigs() {
    return configs;
  }

}
