--
-- Copyright (c) 2024 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="eu",date="2024-09-23T06:15:24Z",numCharacters=21,lookup={},recordSizeInBytes=2,encodingOrder={0,1,3}}
local F

-- chunk size: 36
F = function() provider.lookup[1] = "\10\29\10\29\10\29\10\29\10\29\10\29\10\13\10\13\10\13\10\13\10\13\10\13\10\13\10\13\10\13\4\4\4\4\4\4" end F()

F = nil
RaiderIO.AddProvider(provider)
