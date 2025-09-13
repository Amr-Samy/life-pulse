import 'package:life_pulse/presentation/resources/index.dart';

class CommonDropdownButton extends StatelessWidget {
  RxString? chosenValue=''.obs;
  String? chosenValueDisplayText='gender';
  final String? hintText;
  List<String>? itemsList;
  final Function(dynamic value)? onChanged;
  final String? Function(String?)? validator;
  CommonDropdownButton({
    Key? key,
    this.chosenValue,
    this.hintText,
    this.itemsList,
    this.onChanged,
    this.validator,
    this.chosenValueDisplayText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> DropdownButtonFormField<String>(
          key: UniqueKey(),
        decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: true,
          contentPadding: EdgeInsets.only(right: AppPadding.p8,left: AppPadding.p8),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: AppSize.s0),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8),),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.primary, width: 1.0        ),
            borderRadius: BorderRadius.all(
              Radius.circular(AppSize.s8),
            ),
          ) ,
          enabledBorder:   OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent,width: AppSize.s0),
            borderRadius: BorderRadius.all(
              Radius.circular(AppSize.s8),
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1,color: Colors.red),
              borderRadius: BorderRadius.circular(AppSize.s8)),
          // prefixIcon: Icon(
          //     (chosenValue == itemsList?[0])?Icons.male_rounded :(chosenValue == itemsList?[1])? Icons.female : Icons.male_rounded,
          //     color: ColorManager.grey),
        ),
        elevation: 1,
        validator:validator,
        isExpanded: true,
        hint: Text(hintText ?? '',style: getSemiBoldStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color!,
            fontSize: FontSize.s16),),
        iconSize: 30,
        // iconEnabledColor: AppColors.mainColor,
        // icon: const Icon(Icons.keyboard_arrow_down_rounded,size: 25,),
        // style: const TextStyle(color: AppColors.mainColor),
        borderRadius: BorderRadius.circular(AppSize.s8) ,
        items: itemsList?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            key: UniqueKey(),
            value: value,
            child: Text(value.tr),
          );
        }).toList(),
        onChanged:onChanged,
        value: chosenValue?.value ==""?null: chosenValue?.value,
        dropdownColor: Theme.of(context).cardColor,
      ),
    );
  }
}