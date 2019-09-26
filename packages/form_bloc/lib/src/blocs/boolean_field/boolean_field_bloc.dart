part of '../field/field_bloc.dart';

/// A `FieldBloc` used for `bool` type.
class BooleanFieldBloc
    extends FieldBlocBase<bool, bool, BooleanFieldBlocState> {
  /// ### Properties:
  ///
  /// * [initialValue] : The initial value of the field,
  /// by default is `false`.
  /// * [isRequired] : If is `true`,
  /// [Validators.requiredBooleanFieldBloc] is added to [validators],
  /// by default is `true`.
  /// * [validators] : List of [Validator]s.
  /// Each time the `value` will change,
  /// if the [FormBloc] that use this [BooleanFieldBloc] has set
  /// in the `super` constructor `autoValidate = true`,
  /// the `value` is passed to each `validator`,
  /// and if any `validator` returns a `String error`,
  /// it will be added to [BooleanFieldBlocState.error].
  /// Else if `autoValidate = false`, the value will be checked only
  /// when you call [validate] which is called automatically when call [FormBloc.submit].
  /// * [suggestions] : This need be a [Suggestions] and will be
  /// added to [BooleanFieldBlocState.suggestions].
  /// It is used to suggest values, usually from an API,
  /// and any of those suggestions can be used to update
  /// the value using [updateValue].
  /// * [toStringName] : This will be added to [BooleanFieldBlocState.toStringName].
  BooleanFieldBloc({
    bool initialValue = false,
    bool isRequired = true,
    List<Validator<bool>> validators,
    Suggestions<bool> suggestions,
    String toStringName,
  })  : assert(initialValue != null),
        assert(isRequired != null),
        super(
          initialValue,
          isRequired,
          Validators.requiredBooleanFieldBloc,
          validators,
          suggestions,
          toStringName,
        );

  @override
  BooleanFieldBlocState get initialState => BooleanFieldBlocState(
        value: _initialValue,
        error: _getInitialStateError(),
        isInitial: true,
        isRequired: _isRequired,
        suggestions: _suggestions,
        isValidated: _isValidated,
        toStringName: _toStringName,
      );

  /// Set the `value` to `false` of the current state.
  ///
  /// {@macro form_bloc.field_bloc.update_value}
  @override
  void clear() => dispatch(UpdateFieldBlocValue(false));
}