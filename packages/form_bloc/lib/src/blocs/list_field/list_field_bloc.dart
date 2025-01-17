part of '../field/field_bloc.dart';

class ListFieldBlocState<T extends FieldBloc, ExtraData> extends Equatable
    with FieldBlocStateBase {
  final String name;
  final List<T> fieldBlocs;
  final ExtraData? extraData;
  @override
  final FormBloc? formBloc;

  ListFieldBlocState({
    required this.name,
    required this.fieldBlocs,
    required this.extraData,
    required this.formBloc,
  });

  ListFieldBlocState<T, ExtraData> copyWith({
    List<T>? fieldBlocs,
    Param<FormBloc?>? formBloc,
    Param<ExtraData>? extraData,
  }) {
    return ListFieldBlocState(
      name: name,
      fieldBlocs: fieldBlocs ?? this.fieldBlocs,
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

class ListFieldBloc<T extends FieldBloc, ExtraData>
    extends Cubit<ListFieldBlocState<T, ExtraData>> with FieldBloc {
  bool _autoValidate = true;

  ListFieldBloc({
    String? name,
    List<T>? fieldBlocs,
    ExtraData? extraData,
  }) : super(ListFieldBlocState(
          name: name ?? Uuid().v1(),
          fieldBlocs: fieldBlocs ?? const [],
          formBloc: null,
          extraData: extraData,
        ));

  List<T> get value => state.fieldBlocs;

  void addFieldBloc(T fieldBloc) => addFieldBlocs([fieldBloc]);

  void addFieldBlocs(List<T> fieldBlocs) {
    final stateSnapshot = state;
    if (fieldBlocs.isNotEmpty) {
      emit(stateSnapshot.copyWith(
        fieldBlocs: [...stateSnapshot.fieldBlocs, ...fieldBlocs],
      ));

      if (state.formBloc != null) {
        FormBlocUtils.updateFormBloc(
          fieldBlocs: fieldBlocs,
          formBloc: state.formBloc,
          autoValidate: _autoValidate,
        );

        state.formBloc!.add(RefreshFieldBlocsSubscription());
      }
    }
  }

  /// Removes the [FieldBloc] in the [index].
  void removeFieldBlocAt(int index) {
    final stateSnapshot = state;

    if ((stateSnapshot.fieldBlocs.length > index)) {
      final newFieldBlocs = [...stateSnapshot.fieldBlocs];
      final removableFiled = newFieldBlocs.removeAt(index);
      emit(state.copyWith(fieldBlocs: newFieldBlocs));

      if (state.formBloc != null) {
        FormBlocUtils.removeFormBloc(
          fieldBlocs: [removableFiled],
          formBloc: state.formBloc,
        );

        state.formBloc!.add(RefreshFieldBlocsSubscription());
      }
    }
  }

  /// Removes all [FieldBloc]s that satisfy [test].
  void removeFieldBlocsWhere(bool Function(T element) test) {
    final stateSnapshot = state;

    final newFieldBlocs = [...stateSnapshot.fieldBlocs];

    final fieldBlocsRemoved = <T>[];

    newFieldBlocs.removeWhere((e) {
      if (test(e)) {
        fieldBlocsRemoved.add(e);
        return true;
      }
      return false;
    });

    emit(state.copyWith(
      fieldBlocs: newFieldBlocs,
    ));

    if (state.formBloc != null) {
      FormBlocUtils.removeFormBloc(
        fieldBlocs: fieldBlocsRemoved,
        formBloc: state.formBloc,
      );

      state.formBloc!.add(RefreshFieldBlocsSubscription());
    }
  }

  void updateExtraData(ExtraData extraData) {
    emit(state.copyWith(
      extraData: Param(extraData),
    ));
  }

  // ========== INTERNAL USE ==========

  /// See [FieldBloc.updateFormBloc]
  @override
  void updateFormBloc(FormBloc formBloc, {bool autoValidate = false}) {
    _autoValidate = autoValidate;

    emit(state.copyWith(
      formBloc: Param(formBloc),
    ));

    FormBlocUtils.updateFormBloc(
      fieldBlocs: state.fieldBlocs,
      formBloc: formBloc,
      autoValidate: _autoValidate,
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
        fieldBlocs: state.fieldBlocs,
        formBloc: formBloc,
      );
    }
  }

  @override
  String toString() {
    return '$runtimeType';
  }
}
