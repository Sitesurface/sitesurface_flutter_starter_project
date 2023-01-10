import 'package:flutter/material.dart';

String errorHandler(BuildContext context, String errorCode) {
  switch (errorCode) {
    case 'wrong-password':
      return "Wrong password provided for user";
    case 'something-went-wrong':
      return "Something went wrong";
    case 'session-expired':
      return "Session expired. Retry";
    case 'weak-password':
      return "The password provided is too weak.";
    case 'email-already-in-use':
      return "The account already exists for that email.";
    case 'invalid-verification-code':
      return "The provided code is incorrect";
    case 'invalid-phone-number':
      return "The provided phone number is not valid.";
    case 'account-exists-with-different-credential':
      return "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.";
    case 'invalid-credential':
      return "Error occurred while accessing credentials. Try again.";
    case 'error-uploading-photos':
      return "Error uploading images, Try again";
    case 'subcategory-required':
      return "Subcategory is required";
    case 'description-required':
      return "Description is required";
    case 'condition-required':
      return "Condition is required";
    case 'image-required':
      return "At least 1 image is required";
    case 'category-required':
      return "Category is required";
    case 'address-required':
      return "Adderss is required";
    case 'age-required':
      return "Age is also required";
    case 'title-required':
      return "Title is required";
    default:
      return errorCode;
  }
}
