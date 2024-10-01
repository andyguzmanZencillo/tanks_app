import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tanks_app/core/helpers/dialog_handler/cubit/dialog_handler_cubit.dart';
import 'package:tanks_app/core/widgets/button_custom.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 100),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              strokeWidth: 5,
              color: Colors.blue[900],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 36, 36, 36),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class Loading {
  static late BuildContext _context;
  static void show(BuildContext context) {
    _context = context;
    showCupertinoDialog<void>(
      context: context,
      builder: (_) => SafeArea(
        child: PopScope(
          child: Container(
            color: Colors.black12,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  static void showText(BuildContext context, String text) {
    _context = context;
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogText(
          text: text,
        );
      },
    );
  }

  static void close() {
    Navigator.pop(_context);
  }
}

class DialogText extends StatelessWidget {
  const DialogText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        padding: const EdgeInsets.all(20),
        //height: 80,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color.fromARGB(255, 243, 170, 25),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 56, 56, 56),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogTextBackground extends StatelessWidget {
  const DialogTextBackground({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      padding: const EdgeInsets.all(20),
      //height: 80,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Color.fromARGB(255, 243, 170, 25),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 56, 56, 56),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DialogData {
  DialogData({
    required this.message,
    required this.title,
    required this.textButton,
    required this.onPressed,
    required this.barrierDismissible,
  });

  const DialogData.empty()
      : message = '',
        title = '',
        textButton = '',
        onPressed = null,
        barrierDismissible = true;

  final String message;
  final String title;
  final String textButton;
  final void Function()? onPressed;
  final bool barrierDismissible;
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required this.dialogData,
    this.activeCloseButton = true,
    super.key,
  });
  final DialogData dialogData;
  final bool activeCloseButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.only(
        left: 40,
        right: 40,
        bottom: 40,
      ),
      icon: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: const Icon(
                Icons.error,
                size: 50,
                color: Colors.redAccent,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  if (activeCloseButton) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ),
        ],
      ),
      title: Text(
        dialogData.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        dialogData.message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black54, fontSize: 16),
      ),
      actions: <Widget>[
        ButtonCustom(
          text: dialogData.textButton,
          onPressed: dialogData.onPressed ?? () {},
          backgroundColor: Colors.redAccent,
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class DialogManagment extends StatelessWidget {
  const DialogManagment({required this.dialog, super.key});

  DialogManagment.good({
    required DialogData dialogData,
    super.key,
  }) : dialog = GoodDialog(dialogData: dialogData);
  DialogManagment.error({
    required DialogData dialogData,
    super.key,
  }) : dialog = ErrorDialog(dialogData: dialogData);

  DialogManagment.info({
    required DialogData dialogData,
    super.key,
  }) : dialog = InfoDialog(dialogData: dialogData);

  final Widget dialog;

  @override
  Widget build(BuildContext context) {
    return dialog;
  }
}

class GoodDialog extends StatelessWidget {
  const GoodDialog({
    required this.dialogData,
    super.key,
  });
  final DialogData dialogData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      iconPadding: const EdgeInsets.only(top: 20, bottom: 20),
      actionsPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      icon: const Icon(
        Icons.task_alt,
        size: 50,
        color: Colors.green,
      ),
      title: Text(
        dialogData.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        dialogData.message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: <Widget>[
        ButtonCustom(
          backgroundColor: Colors.green,
          text: dialogData.textButton,
          onPressed: dialogData.onPressed ?? () {},
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

class GoodDialogBackground extends StatelessWidget {
  const GoodDialogBackground({
    required this.dialogData,
    required this.dialogType,
    super.key,
  });

  final DialogData dialogData;
  final DialogType dialogType;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color iconColor;

    // Establecer colores según el tipo de diálogo
    if (dialogType == DialogType.success) {
      backgroundColor = Colors.white;
      iconColor = Colors.green;
    } else {
      backgroundColor = Colors.red[50]!;
      iconColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            dialogType == DialogType.success ? Icons.task_alt : Icons.error,
            size: 50,
            color: iconColor,
          ),
          const SizedBox(height: 20),
          Text(
            dialogData.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            dialogData.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: iconColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: dialogData.onPressed ?? () {},
            child: Text(dialogData.textButton),
          ),
        ],
      ),
    );
  }
}

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    required this.dialogData,
    super.key,
  });
  final DialogData dialogData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      iconPadding: const EdgeInsets.only(top: 20, bottom: 20),
      actionsPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      icon: const Icon(
        Icons.info,
        size: 50,
        color: Colors.blueAccent,
      ),
      title: Text(
        dialogData.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        dialogData.message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: <Widget>[
        ButtonCustom(
          text: dialogData.textButton,
          onPressed: dialogData.onPressed ?? () {},
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

abstract class Dialogs {
  static late BuildContext _context;

  static void showErrorMessage(
    BuildContext context,
    DialogData dialogData,
  ) {
    _context = context;
    showDialog<void>(
      context: context,
      barrierDismissible: dialogData.barrierDismissible,
      builder: (BuildContext context) {
        return ErrorDialog(dialogData: dialogData);
      },
    );
  }

  static void showGoodMessage(
    BuildContext context,
    DialogData dialogData,
  ) {
    _context = context;
    showDialog<void>(
      context: context,
      barrierDismissible: dialogData.barrierDismissible,
      builder: (BuildContext context) {
        return GoodDialog(dialogData: dialogData);
      },
    );
  }

  static void showInfoMessage(
    BuildContext context,
    DialogData dialogData,
  ) {
    _context = context;
    showDialog<void>(
      context: context,
      barrierDismissible: dialogData.barrierDismissible,
      builder: (BuildContext context) {
        return InfoDialog(dialogData: dialogData);
      },
    );
  }

  static void close() {
    Navigator.pop(_context);
  }
}

abstract class DialogsBottom {
  static late BuildContext _context;
  static void showModalBottom(BuildContext context, Widget child) {
    _context = context;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (_) {
        return child;
      },
    );
  }

  static void close() {
    Navigator.pop(_context);
  }
}
