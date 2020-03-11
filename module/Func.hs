
module Func where
    import Types
    
    getAcc::Token->String
    getAcc (Token a b) = b

    fromJust::Maybe a->a
    fromJust (Just a)=a
    fromJust Nothing=error "Oops, you goofed up, fool."

    getID::Cred->String
    getID (Cred a b)=a

    getSec::Cred->String
    getSec (Cred a b)=b