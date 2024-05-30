add_llvm_component_library(LLVMObfuscation
  Utils.cpp
  AliasAccess.cpp
  BogusControlFlow.cpp
  Flattening.cpp
  IndirectBranch.cpp
  IndirectCall.cpp
  GlobalsEncryption.cpp
  Pipeline.cpp

  LINK_COMPONENTS
  Core
  Support
  Analysis
  TransformUtils
  
  )
