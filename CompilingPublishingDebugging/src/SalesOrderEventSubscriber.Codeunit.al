/// <summary>
/// Event subscriber for validating sales line changes.
/// DEBUGGING SHOWCASE: Practice debugging event subscribers.
/// </summary>
codeunit 80101 "Sales Order Event Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateQuantitySalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        Item: Record Item;
    begin
        // BREAKPOINT HERE: Set a breakpoint to catch quantity changes
        if Rec.Type <> Rec.Type::Item then
            exit;

        // CONDITIONAL BREAKPOINT: Set condition: Rec.Quantity > 50
        if Item.Get(Rec."No.") then begin
            Item.CalcFields(Inventory);

            if Item.Inventory < Rec.Quantity then
                Message('Warning: Quantity (%1) exceeds available inventory (%2) for item %3',
                    Rec.Quantity, Item.Inventory, Rec."No.");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", OnAfterConfirmPost, '', false, false)]
    local procedure SalesPostYesNo_OnAfterConfirmPost()
    begin
        SimulateLongRunningProcess();
    end;

    local procedure SimulateLongRunningProcess()
    begin
        Sleep(30000);
    end;
}
