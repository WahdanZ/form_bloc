part of '../field/field_bloc.dart';

class GroupFieldBlocState<T extends FieldBloc, ExtraData> extends Equatable
    with FieldBlocStateBase {
  final String name;
  final Map<String, T> fieldBlocs;
  final ExtraData? extraData;
  @override
  final FormBloc? formBloc;

  GroupFieldBlocState({
    required this.name,
    required List<T> fieldBlocs,
    required this.extraData,
    required this.formBloc,
  }) :
        //ignore: prefer_for_elements_to_map_fromiterable
        fieldBlocs = Map.fromIterable(
          fieldBlocs,
          key: (dynamic f) {
            return f.state.name as String;
          },
          value: (dynamic f) {
            return f as T;
          },
        );

  GroupFieldBlocState<T, ExtraData> copyWith({
    Param<ExtraData>? extraData,
    Param<FormBloc?>? formBloc,
  }) {
    return GroupFieldBlocState(
      name: name,
      fieldBlocs: fieldBlocs.values.toList(),
      extraData: extraData == null ? this.extraData : extraData.value,
      formBloc: formBloc == null ? this.formBloc : formBloc.value,
    );
  }

  @override
  List<Object?> get props => [name, fieldBlocs, extraData, formBloc];

  @override
  String toString() {
    var _string = '';
    _string += '$runtimeType {';
    _string += ',\n  name: $name';
    _string += ',\n  extraData: $extraData';
    _string += ',\n  formBloc: $formBloc';
    _string += ',\n  fieldBlocs: $fieldBlocs';
    _string += '\n}';
    return _string;
  }
}

class GroupFieldBloc<T extends FieldBloc, ExtraData>
    extends Cubit<GroupFieldBlocState<T, ExtraData>> with FieldBloc {
  GroupFieldBloc({
    String? name,
    List<T>? fieldBlocs,
    ExtraData? extraData,
  }) : super(GroupFieldBlocState(
          name: name ?? Uuid().v1(),
          fieldBlocs: fieldBlocs ?? const [],
          formBloc: null,
          extraData: extraData,
        ));

  void updateExtraData(ExtraData extraData) {
    emit(state.copyWith(
      extraData: Param(extraData),
    ));
  }

  // ========== INTERNAL USE ==========

  /// See [FieldBloc.updateFormBloc]
  @override
  void updateFormBloc(FormBloc formBloc, {bool autoValidate = false}) {
    emit(state.copyWith(
      formBloc: Param(formBloc),
    ));

    FormBlocUtils.updateFormBloc(
      fieldBlocs: state.fieldBlocs.values,
      formBloc: formBloc,
      autoValidate: autoValidate,
    );
  }

  /// See [FieldBloc.removeFormBloc]
  @override
  void removeFormBloc(FormBloc formBloc) {
    if (state.formBloc == formBloc) {
      emit(state.copyWith(
        formBloc: Param(null),
      ));

      FormBlocUtils.removeFormBloc(
        fieldBlocs: state.fieldBlocs.values,
        formBloc: formBloc,
      );
    }
  }

  @override
  String toString() {
    return '$runtimeType';
  }
}
