/// <summary>
/// Simple page to test sales order discount processing.
/// DEBUGGING SHOWCASE: Use this page to trigger debugging scenarios.
/// </summary>
page 80100 "Sales Order Debug Helper"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Sales Order Debug Helper';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SalesOrderNo; SalesOrderNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        if Page.RunModal(Page::"Sales Order List", SalesHeader) = Action::LookupOK then begin
                            SalesOrderNo := SalesHeader."No.";
                            Text := SalesOrderNo;
                            exit(true);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ApplyDiscounts)
            {
                ApplicationArea = All;
                Caption = 'Apply Volume Discounts';
                ToolTip = 'Apply volume discounts to the selected sales order lines.';
                Image = Discount;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesLineProcessor: Codeunit "Sales Line Processor";
                begin
                    // BREAKPOINT HERE: Set a breakpoint before processing
                    if SalesOrderNo = '' then
                        Error('Please select a sales order');

                    SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo);

                    // Step into (F11) to debug the processor
                    SalesLineProcessor.ApplyVolumeDiscounts(SalesHeader);
                end;
            }

            action(OpenOrder)
            {
                ApplicationArea = All;
                Caption = 'Open Order';
                ToolTip = 'Open the selected sales order for review.';
                Image = Order;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    if SalesOrderNo = '' then
                        Error('Please select a sales order');

                    SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo);
                    Page.Run(Page::"Sales Order", SalesHeader);
                end;
            }
        }
    }

    var
        SalesOrderNo: Code[20];
}
