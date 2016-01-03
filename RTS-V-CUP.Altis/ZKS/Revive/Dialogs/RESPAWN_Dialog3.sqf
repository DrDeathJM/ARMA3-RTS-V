
sleep 0.02;
_ok = createDialog "ZKS_DlgReviveDisplay";
if (!_ok) exitwith {hint "Dialog Error";};
_dialog = _this select 0;

ctrlSetText [0001029, format["%1", _dialog]];

sleep 5;
closedialog 333091;

if (1 == 1) exitwith {};