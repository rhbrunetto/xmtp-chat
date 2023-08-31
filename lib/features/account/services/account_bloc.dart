import 'package:eth_chat/features/account/data/my_account.dart';
import 'package:bloc/bloc.dart';
import 'package:eth_chat/utils/processing_state.dart';
import 'package:injectable/injectable.dart';

typedef AccountState = ProcessingState<MyAccount>;

@injectable
class AccountBloc extends Cubit<AccountState> {
  AccountBloc() : super(const AccountState.failed());

  void setAccount(String address) => emit(
        ProcessingState.success(
          MyAccount(address: address),
        ),
      );
}
