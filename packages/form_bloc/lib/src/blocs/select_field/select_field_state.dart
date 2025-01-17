part of '../field/field_bloc.dart';

class SelectFieldBlocState<Value, ExtraData>
    extends FieldBlocState<Value?, Value, ExtraData?> {
  final List<Value> items;

  SelectFieldBlocState({
    required Value? value,
    required Object? error,
    required bool isInitial,
    required Suggestions<Value>? suggestions,
    required bool isValidated,
    required bool isValidating,
    FormBloc? formBloc,
    required String name,
    this.items = const [],
    dynamic Function(Value? value)? toJson,
    ExtraData? extraData,
  }) : super(
          value: value,
          error: error,
          isInitial: isInitial,
          suggestions: suggestions,
          isValidated: isValidated,
          isValidating: isValidating,
          formBloc: formBloc,
          name: name,
          toJson: toJson,
          extraData: extraData,
        );

  @override
  SelectFieldBlocState<Value, ExtraData> copyWith({
    Param<Value?>? value,
    Param<Object?>? error,
    bool? isInitial,
    Param<Suggestions<Value>?>? suggestions,
    bool? isValidated,
    bool? isValidating,
    Param<FormBloc?>? formBloc,
    List<Value>? items,
    Param<ExtraData?>? extraData,
  }) {
    return SelectFieldBlocState(
      value: value == null ? this.value : value.value,
      error: error == null ? this.error : error.value,
      isInitial: isInitial ?? this.isInitial,
      suggestions: suggestions == null ? this.suggestions : suggestions.value,
      isValidated: isValidated ?? this.isValidated,
      isValidating: isValidating ?? this.isValidating,
      formBloc: formBloc == null ? this.formBloc : formBloc.value,
      name: name,
      items: items ?? this.items,
      toJson: _toJson,
      extraData: extraData == null ? this.extraData : extraData.value,
    );
  }
  // @override
  // SelectFieldBlocState<Value, ExtraData> copyWith(
  //     {Optional<List<Value>>? value,
  //     Optional<String>? error,
  //     bool? isInitial,
  //     Optional<Suggestions<Value>>? suggestions,
  //     bool? isValidated,
  //     bool? isValidating,
  //     FormBloc? formBloc,
  //     Optional<List<Value>>? items,
  //     Optional<ExtraData?>? extraData}) {
  //   return SelectFieldBlocState(
  //     value: value == null ? this.value : value.orNull,
  //     error: error == null ? this.error : error.orNull,
  //     isInitial: isInitial ?? this.isInitial,
  //     suggestions: suggestions == null ? this.suggestions : suggestions.orNull,
  //     isValidated: isValidated ?? this.isValidated,
  //     isValidating: isValidating ?? this.isValidating,
  //     formBloc: formBloc ?? this.formBloc,
  //     name: name,
  //     items: items == null ? this.items : items.orNull,
  //     toJson: _toJson,
  //     extraData: extraData == null ? this.extraData : extraData.orNull,
  //   );
  // }

  @override
  String toString() => _toStringWith(',\n  items: $items');

  @override
  List<Object?> get props => [
        value,
        error,
        isInitial,
        suggestions,
        isValidated,
        isValidating,
        extraData,
        formBloc,
        items,
      ];
}
