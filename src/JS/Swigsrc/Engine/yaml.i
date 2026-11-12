/*
 * Copyright 2026 D.Jorand.
 *
 * This file is part of OpenXcom.
 *
 * OpenXcom is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OpenXcom is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenXcom.	If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%echo "Processing YamlNodeReader.i"

%template(YAMLNodeReaderPVector) std::vector<const OpenXcom::YAML::YamlNodeReader*>;
%newobject OpenXcom::YAML::YamlNodeReader::getChild;
%newobject OpenXcom::YAML::YamlNodeWriter::mapAdd;
%newobject OpenXcom::YAML::YamlNodeWriter::seqAdd;
#endif


// ---------------------------------------------------------
// Macros
// ---------------------------------------------------------
// The JSConvertPtr macros implements a function for a given class that
// convert a C++ instance into its wrapping JSValue.
// This function is used in the code to create the `self` parameter
// in callbacks from the `this` pointer.
// The JSValue needs to be freed after use (JS_FreeValue).
#ifndef DOXYGEN_SHOULD_SKIP_THIS
%define JSConvertYAMLPtr(type)
%wrapper %{
namespace OpenXcom {
namespace YAML {
JSValue JSConvert ## type ## Ptr(JSContext *ctx, const OpenXcom::YAML::type* ptr) {
	return SWIG_QuickJS_NewPointerObj(ctx, (void*)ptr, SWIGTYPE_p_OpenXcom__YAML__ ## type, 0);
}
}
}
%}
%enddef
#endif // DOXYGEN_SHOULD_SKIP_THIS

namespace OpenXcom
{

namespace YAML
{

class YamlRootNodeReader;
class YamlRootNodeWriter;


////////////////////////////////////////////////////////////
//					YamlNodeReader
////////////////////////////////////////////////////////////

/// Basic string wrapper to differentiate from normal strings
struct YamlString
{
	std::string yaml;

	YamlString() = default;
	YamlString(std::string yamlString);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		return strdup(self->yaml.c_str());
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif
};


////////////////////////////////////////////////////////////
//					YamlNodeReader
////////////////////////////////////////////////////////////

class YamlNodeReader
{
public:

#if 0
	YamlNodeReader(); // vector demands a default constructor despite it never being used
	YamlNodeReader(const YamlNodeReader& other) = default;
	YamlNodeReader(YamlNodeReader&& other) noexcept = default;
	YamlNodeReader(const YamlRootNodeReader&) = delete; // no slicing allowed

	YamlNodeReader(const ryml::ConstNodeRef& node);
	YamlNodeReader(const ryml::ConstNodeRef& node, bool useIndex);

	/// Returns a copy of the current mapping container with O(1) access to the children. O(n) is spent building the index.
	YamlNodeReader useIndex() const;
#endif


	/// Returns a string_view wrapping the key. No string construction or deserialization occurs.
	std::string_view key() const;

	/// Returns a string_view wrapping the value. No string construction or deserialization occurs.
	std::string_view val() const;


#if 0
	/// Deserializes the value of the found child into the outputValue. Throws if the node is invalid or the key doesn't exist.
	template <typename OutputType>
	void readNode(ryml::csubstr key, OutputType& outputValue) const;

	/// Deserializes the value of the found child into the outputValue. If the node is invalid or the key doesn't exist, outputValue is set to defaultValue.
	template <typename OutputType>
	void readNode(ryml::csubstr key, OutputType& outputValue, const OutputType& defaultValue) const;

	/// Returns a deserialized key of the current node. Throws if the node is invalid or itself has no key.
	template <typename OutputType>
	OutputType readKey() const;

	/// Returns a deserialized key of the current node, or a default value if the node is invalid or itself has no key
	template <typename OutputType>
	OutputType readKey(const OutputType& defaultValue) const;

	/// Returns a deserialized value of the current node. Throws if the node is invalid.
	template <typename OutputType>
	OutputType readVal() const;

#endif
	/// Returns a deserialized value of the current node, or a default value if the node is invalid
	template <typename OutputType>
	OutputType readVal(const OutputType& defaultValue) const;
	%template(readValAsInt) readVal<int>;
	%template(readValAsString) readVal<std::string>;
	%template(readValAsBool) readVal<bool>;
	%template(readValAsDouble) readVal<double>;

	/// Returns a deserialized binary value of the current node. Throws if the node is invalid.
	std::vector<char> readValBase64() const;


#if 0
	/// Returns false if the node is invalid or the key doesn't exist. Otherwise returns true and deserializes the value of the found child into the outputValue.
	template <typename OutputType>
	bool tryRead(ryml::csubstr key, OutputType& outputValue) const;

	/// Returns false if the node is invalid or the key doesn't exist. Otherwise returns true and deserializes the value of the found child into the outputValue.
	template <typename ReadType, typename OutputType>
	bool tryReadAs(ryml::csubstr key, OutputType& outputValue) const;

	/// Returns false if the node is invalid or itself has no key. Otherwise returns true and deserializes the key of the current node into the outputValue.
	template <typename OutputType>
	bool tryReadKey(OutputType& outputValue) const;

	/// Returns false if the node is invalid. Otherwise returns true and deserializes the value of the current node into the outputValue.
	template <typename OutputType>
	bool tryReadVal(OutputType& outputValue) const;
#endif

	/// Returns the number of children of the current node. O(n) complexity, or O(1) if index is used.
	size_t childrenCount() const;

#if 0
	// See getChild below
	/// Builds a vector of children and retuns it
	std::vector<YamlNodeReader> children() const;
#endif

	/// Returns whether the current node is valid. Just use the bool operator instead.
	bool isValid() const;
	/// Returns true if the current node is a mapping container
	bool isMap() const;
	/// Returns true if the current node is a sequence container
	bool isSeq() const;
	/// Returns true if the current node has a scalar value (empty strings and null constants count)
	bool hasVal() const;
	/// Returns true if the current node has a scalar value and this value is one of the null constants
	bool hasNullVal() const;
	/// Returns true if the current node has a scalar value and an explicit tag
	bool hasValTag() const;

#if 0
	/// Returns true if the node is valid, has a tag, and the tag is a core tag
	bool hasValTag(ryml::YamlTag_e tag) const;
#endif
	/// Returns true if the node is valid, has a tag, and the tag's name equals tagName
	bool hasValTag(const std::string& tagName) const;
	/// Returns node's value's tag, or an empty string if there is none
	std::string getValTag() const;

	/// Serializes the node and its descendants to a YamlString
	const YamlString emit() const;
	/// Serializes the node's descendants to a YamlString
	const YamlString emitDescendants() const;
	/// Serializes the node's descendants, plus default values, to a YamlString
	const YamlString emitDescendants(const YamlNodeReader& defaultValuesReader) const;

#if 0
	/// Returns an object that contains data on where the current node is located in the original yaml
	ryml::Location getLocationInFile() const;
#endif

#if 0
	/// Returns a child in the current mapping container or an invalid child
	YamlNodeReader operator[](ryml::csubstr key) const;
	/// Returns a child at a specific position or an invalid child
	YamlNodeReader operator[](size_t pos) const;
	/// Returns whether the current node is valid
	explicit operator bool() const;
#endif


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		const char *t;
		if (self->isMap()) t = "<map>";
		if (self->isSeq()) t = "<seq>";
		if (self->hasVal()) t = "<scalar>";
		snprintf(buffer, 128, "YamlNodeReader%s@%p", t, self);
		return strdup(buffer);
	}

	//%newobject, see above
	/// Returns a child in the current mapping container or an invalid child (operator [])
	const YamlNodeReader* getChild(const std::string &key) {
		return new OpenXcom::YAML::YamlNodeReader((*self)[ryml::csubstr(key.c_str(), key.length())]);
	}
	//%newobject, see above
	/// Returns a child at a specific position or an invalid child (operator [])
	const YamlNodeReader* getChild(size_t pos) {
		return new OpenXcom::YAML::YamlNodeReader((*self)[pos]);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertYAMLPtr(YamlNodeReader);


////////////////////////////////////////////////////////////
//					YamlRootNodeReader
////////////////////////////////////////////////////////////

class YamlRootNodeReader : public YamlNodeReader
{
public:

	YamlRootNodeReader(const std::string& fullFilePath, bool onlyInfoHeader = false, bool resolveReferences = true);
	YamlRootNodeReader(const YamlString& yamlString, std::string description, bool resolveReferences = true);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "YamlRootNodeReader@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertYAMLPtr(YamlRootNodeReader);


////////////////////////////////////////////////////////////
//					YamlNodeWriter
////////////////////////////////////////////////////////////

class YamlNodeWriter
{
public:

#if 0
	/// Converts writer to a reader
	YamlNodeReader toReader();
#endif

#if 0
	/// Adds a container child to the current sequence container
	YamlNodeWriter write();
	/// Adds a container child to the current mapping container
	YamlNodeWriter operator[](ryml::csubstr key);

#endif

#ifndef DOXYGEN_SHOULD_SKIP_THIS
	%extend {
#endif
	/// Adds a container child to the current sequence container
	//%newobject, see above
	YamlNodeWriter *seqAdd() {
		return new OpenXcom::YAML::YamlNodeWriter(self->write());
	}
	/// Adds a container child to the current mapping container
	//%newobject, see above
	YamlNodeWriter *mapAdd(const std::string& key) {
		ryml::csubstr k = self->saveString(key);
		return new OpenXcom::YAML::YamlNodeWriter((*self)[k]);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
	}
#endif


#if 0
	/// Adds a scalar value child to the current sequence container, serializing the provided value
	template <typename InputType>
	YamlNodeWriter write(const InputType& inputValue);
	/// Adds a scalar value child to the current mapping container, serializing the provided value
	template <typename InputType>
	YamlNodeWriter write(ryml::csubstr key, const InputType& inputValue);

	/// Adds a scalar value child to the current mapping container, serializing the provided value
	template <typename WriteType, typename InputType>
	YamlNodeWriter writeAs(ryml::csubstr key, const InputType& inputValue);

	/// If the inputVector is not empty, adds a sequence container child to the current mapping container.
	/// The callback (YamlNodeWriter w, InputType val) should specify how to write a vector element to the sequence container.
	template <typename InputType, typename Func>
	void write(ryml::csubstr key, const std::vector<InputType>& inputVector, Func callback);
#endif
	//template <typename InputType>
	//void write(const InputType& inputValue);
	//%template(writeValAsInt) write<int>;
	//%template(writeValAsString) write<std::string>;
	//%rename(writeSeqItemAsInt) OpenXcom::YAML::YamlNodeWriter::write<int>(const InputType& inputValue);
	//%rename(writeSeqItemAsString) OpenXcom::YAML::YamlNodeWriter::write<std::string>(const InputType& inputValue);

	//template <typename InputType>
	//void write(ryml::csubstr key, const InputType& inputValue);
	//%rename(writeMapItemAsInt) write<int>(ryml::csubstr key, const InputType& inputValue);
	//%rename(writeMapItemAsString) write<std::string>(ryml::csubstr key, const InputType& inputValue);

#ifndef DOXYGEN_SHOULD_SKIP_THIS
	%extend {
#endif
		void write(int v) {
			self->write<int>(v);
		}
		void write(const std::string& v) {
			self->write<const std::string&>(v);
		}
		void write(bool v) {
			self->write<bool>(v);
		}
		void write(double v) {
			self->write<double>(v);
		}

		void write(const std::string& key, int v) {
			ryml::csubstr k = self->saveString(key);
			self->write<int>(k, v);
		}
		void write(const std::string& key, const std::string& v) {
			ryml::csubstr k = self->saveString(key);
			self->write<const std::string>(k, v);
		}
		void write(const std::string& key, bool v) {
			ryml::csubstr k = self->saveString(key);
			self->write<bool>(k, v);
		}
		void write(const std::string& key, double v) {
			ryml::csubstr k = self->saveString(key);
			self->write<double>(k, v);
		}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
	} /* end of %extend */
#endif

#if 0
	/// Adds a scalar value child to the current mapping container, serializing the provided binary data
	YamlNodeWriter writeBase64(ryml::csubstr key, char* data, size_t size);
#endif

#if 0
	/// Try write value if is different that default
	template <typename InputType>
	void tryWrite(ryml::csubstr key, const InputType& inputValue, const std::remove_reference_t<InputType>& defualtValue);

	/// Try write value if is different that default
	template <typename WriteType, typename InputType>
	void tryWriteAs(ryml::csubstr key, const InputType& inputValue, const std::remove_reference_t<InputType>& defualtValue);

	/// Adds a value to the current node.
	template <typename InputType>
	void setValue(const InputType& inputValue);
#endif

	/// Set node value to null
	void setValueNull();

	/// Marks the current node as a mapping container
	void setAsMap();
	/// Marks the current node as a sequence container
	void setAsSeq();
	/// Marks the current node to serialize as single-line flow-style
	void setFlowStyle();
	/// Marks the current node to serialize as multi-line block-style
	void setBlockStyle();
	/// Marks the current node to serialize the scalar in double quotes. Escapes non-printable ASCII characters.
	void setAsQuotedAndEscaped();

	void unsetAsMap();
	void unsetAsSeq();

	/// Saves a string to the internal buffer. In a rare case when a key isn't a string literal, this ensures its lifetime until the serialization is done.
	ryml::csubstr saveString(const std::string& string);

	/// Emits a yaml string based on the current node and its subtree
	YamlString emit();


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "YamlNodeWriter@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertYAMLPtr(YamlNodeWriter);

////////////////////////////////////////////////////////////
//					YamlRootNodeWriter
////////////////////////////////////////////////////////////

class YamlRootNodeWriter : public YamlNodeWriter
{
public:

	YamlRootNodeWriter();
	YamlRootNodeWriter(size_t bufferCapacity);


#ifndef DOXYGEN_SHOULD_SKIP_THIS
%extend {
	%newobject __str__;
#endif
	char *__str__() const {
		char buffer[128];
		snprintf(buffer, 128, "YamlRootNodeWriter@%p", self);
		return strdup(buffer);
	}
#ifndef DOXYGEN_SHOULD_SKIP_THIS
}
#endif

};

JSConvertYAMLPtr(YamlRootNodeWriter);


}  /* end of namespace YAML */

}  /* end of namespace OpenXcom */
