import 'package:cart/presentation/widgets/primary_cart_button.dart';
import 'package:cart/presentation/widgets/secondary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/ui.dart';
import '../../../data/models/user/user_model.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = "edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyles.heading3,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UserLoggedInState) {
          return editProfile(state.userModel);
        }

        return const Center(
          child: Text("An error occured!"),
        );
      })),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Personal Details",
          style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SecondaryTextField(
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
          labelText: "Full Name",
        ),
        const SizedBox(height: 10),
        SecondaryTextField(
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
          labelText: "Phone Number",
        ),
        const SizedBox(height: 10),
        Text("Address",
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SecondaryTextField(
          initialValue: userModel.address,
          onChanged: (value) {
            userModel.address = value;
          },
          labelText: "Address",
        ),
        const SizedBox(height: 10),
        SecondaryTextField(
          initialValue: userModel.city,
          onChanged: (value) {
            userModel.city = value;
          },
          labelText: "City",
        ),
        const SizedBox(height: 10),
        SecondaryTextField(
          initialValue: userModel.state,
          onChanged: (value) {
            userModel.state = value;
          },
          labelText: "State",
        ),
        const SizedBox(height: 10),
        PrimaryCartButton(
            onPressed: () async {
              bool success = await BlocProvider.of<UserCubit>(context)
                  .updateUser(userModel);
              if (success) {
                Navigator.pop(context);
              }
            },
            text: "Save"),
      ],
    );
  }
}
